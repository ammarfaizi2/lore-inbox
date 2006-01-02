Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWABKso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWABKso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 05:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWABKso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 05:48:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55489 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932266AbWABKsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 05:48:43 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
In-Reply-To: <20060102103721.GA8701@elte.hu>
References: <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
	 <20051229224839.GA12247@elte.hu>
	 <1135897092.2935.81.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	 <20060102103721.GA8701@elte.hu>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 11:48:22 +0100
Message-Id: <1136198902.2936.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Your uninline patch might be simple, but the safe way would be Arjan's 
> > approach to start removing all the buggy inline's from .c files.
> 
> sure, that's another thing to do, but it's also clear that there's no 
> reason to force inlines in the -Os case.
> 
> There are 22,000+ inline functions in the kernel right now (inlined 
> about a 100,000 times), and we'd have to change _thousands_ of them. 
> They are causing an unjustified code bloat of somewhere around 20-30%. 
> (some of them are very much justified, especially in core kernel code)

my patch attacks the top bloaters, and gains about 30k to 40k (depending
on compiler). Gaining the other 300k is going to be a LOT of churn, not
just in amount of work... so to some degree my patch shows that it's a
bit of a hopeless battle.


