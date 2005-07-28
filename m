Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVG1HWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVG1HWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVG1HWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:22:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34239 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261310AbVG1HWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:22:34 -0400
Date: Thu, 28 Jul 2005 09:22:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, "K.R. Foley" <kr@cybsft.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
Message-ID: <20050728072210.GA20055@elte.hu>
References: <Pine.OSF.4.05.10507271852030.3210-100000@da410.phys.au.dk> <1122485137.29823.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122485137.29823.109.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> A colleague of mine, well actually the VP of my company of the time, 
> Doug Locke, gave me a perfect example.  If you have a program that 
> runs a nuclear power plant that needs to wake up and run 4 seconds 
> every 10 seconds, and on that same computer you have a program running 
> a washing machine that needs to wake up every 3 seconds and run for 
> one second (I'm using seconds just to make the example simple). Which 
> process gets the higher priority?  The answer is the washing machine.
> 
> Rational: If the power plant was higher priority, the washing machine 
> would fail almost every time, since the power plant program would run 
> for 4 seconds, and since the cycle of the washing machine is 3 
> seconds, it would fail everytime the nuclear power plant program ran.  
> Now if you have the washing machine run in it's cycle, the nuclear 
> power plant can easily make the 4 seconds ever 10 seconds, even when 
> it is interrupted by the washing machine.

nitpicking: i guess the answer also depends on what the precise 
requirement is. If the requirement is 'run for 4 seconds every 10 
seconds, uninterrupted, else the power plant melts down', i'd sure not 
make the washing machine process the higher priority one ;-)

(also, i'd give the power plant process higher priority even if the 
requirement is not as strict, just from a risk POV: what if the washing 
machine control program is buggy and got into an infinite loop 
somewhere.)

	Ingo
