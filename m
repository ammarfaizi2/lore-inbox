Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbTJ1R0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTJ1R0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:26:35 -0500
Received: from gprs192-228.eurotel.cz ([160.218.192.228]:57219 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263640AbTJ1R0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:26:34 -0500
Date: Tue, 28 Oct 2003 18:26:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031028172618.GA2307@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <200310281521.h9SFLQxF024354@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310281521.h9SFLQxF024354@turing-police.cc.vt.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Not sure... We do not want applications to know. Certainly we can't
> > send a signal; SIGPWR already has some meaning and it would be bad to
> > override it.
> 
> You are correct that SIGPWR already has an assigned semantic.
> 
> However, I'm not convinced that we don't want applications to know.
> Others have mentioned timeouts of network connections, and there's other
> issues as well - for instance, on my laptop, it is almost guaranteed (due to my
> work habits) that if I were to suspend it, when it wakes up the network
> configuration would be *wrong*.  It's possible to intuit what the right
> config is by looking at the number of ethernets and their link state, but
> that requires a wakeup of *something* in userspace - blindly going on
> as if nothing happened simply won't work.
> 
> Would having a pair of 'sleep/wakeup' calls in /etc/inittab (similar to the
> powerfail/powerok pair) be a solution here?  

Patrick has a patch to send event down using "hotplug" system.

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
