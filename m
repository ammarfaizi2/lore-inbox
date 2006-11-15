Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030833AbWKOSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030833AbWKOSvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030868AbWKOSvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:51:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32735 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030838AbWKOSvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:51:01 -0500
Date: Wed, 15 Nov 2006 19:49:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20061115184936.GA6389@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <455B5ED8.5090005@goop.org> <20061115184315.GA5078@elte.hu> <455B611C.3010503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B611C.3010503@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> > but it does not actually use the 'normal usermode TLS selector' - it 
> > only loads it.
> >
> > a meaningful test would be to allocate two selector values and load and 
> > read+write memory through both of them.
> >   
> 
> Well, obviously in one case it would need to switch between 
> null/non-null/null.  But yes, good point about using the "usermode" 
> %gs each iteration.  I'll do some more tests.

i'd not even use glibc's %gs but set up two separate selectors. (that's 
a more controlled experiment - someone might run a non-TLS glibc, etc.)

	Ingo
