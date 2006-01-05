Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWAESJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWAESJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWAESJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:09:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49616 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932132AbWAESJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:09:52 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Matt Mackall <mpm@selenic.com>, Chuck Ebbert <76306.1226@compuserve.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
In-Reply-To: <43BD5E6F.1040000@mbligh.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com>
	 <43BC716A.5080204@mbligh.org>
	 <1136463553.2920.22.camel@laptopd505.fenrus.org>
	 <20060105170255.GK3356@waste.org>  <43BD5E6F.1040000@mbligh.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 19:09:36 +0100
Message-Id: <1136484577.2920.56.camel@laptopd505.fenrus.org>
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


> There are tools already around to do this sort of thing as well - 
> "profile directed optimization" or whatever they called it. Seems to be 
> fairly commonly done with userspace, but not with the kernel. I'm not 
> sure why not ... possibly because it's not available for gcc ?

gcc has this for sure
the problem is that it expects the profile info in a special format
that.. gets written to a file. So to do it in the kernel you need
SomeMagic(tm), for example to use the kernel profiler but to let it
output it somehow in a gcc compatible format.


