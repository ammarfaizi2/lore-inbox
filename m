Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWDRO4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWDRO4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWDRO4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:56:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31450 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751049AbWDRO4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:56:40 -0400
Date: Tue, 18 Apr 2006 15:52:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] bad BUG_ON in rtmutex.c
Message-ID: <20060418135249.GA14030@elte.hu>
References: <1145324887.17085.35.camel@localhost.localdomain> <1145362851.5447.12.camel@localhost.localdomain> <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com> <1145365886.5447.28.camel@localhost.localdomain> <1145368228.17085.85.camel@localhost.localdomain> <1145369381.5447.40.camel@localhost.localdomain> <1145370733.17085.110.camel@localhost.localdomain> <1145371913.5447.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145371913.5447.48.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > But, as PI matures, it seems to be more and more acceptable.
> 
> 	I read an article on priority ceiling as another method of doing 
> this. Priority ceiling doesn't seem better, but at the same time I 
> can't imagine how you'd implement it in Linux, or not in a straight 
> forward way .

it's already implemented and can be done in userspace: userspace can do 
it by doing a sys_setscheduler() call when entering the critical 
section, and another one when exiting it. (PI is obviously faster 
because there the futex fastpath can be pure-userspace.)

	Ingo
