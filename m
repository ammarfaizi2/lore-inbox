Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVAVKdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVAVKdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 05:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVAVKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 05:33:06 -0500
Received: from gprs215-125.eurotel.cz ([160.218.215.125]:18064 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262693AbVAVKdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 05:33:03 -0500
Date: Sat, 22 Jan 2005 11:32:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050122103242.GC9357@elf.ucw.cz>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121203425.GB11112@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Yes, but do you care about the performance of syscalls
> > > > which the program isn't allowed to call at all ? ;)
> > > 
> > > Heh, no, but it's for every syscall not just denied ones.  Point is
> > > simply that ptrace (complexity aside) doesn't scale the same.
> > 
> > seccomp is about CPU-intense calculation jobs - the only syscalls
> > allowed are read/write (and sigreturn). UML implements a full kernel
> > via ptrace and CPU-intense applications run at native speed.
> 
> Indeed. Performance is not an issue (in the short term at least, since
> those syscalls will be probably network bound).
> 
> The only reason I couldn't use ptrace is what you found, that is the oom
> killing of the parent (or a mistake of the CPU seller that kills it by
> mistake by hand, I must prevent him to screw himself ;). Even after
> fixing ptrace, I've an hard time to prefer ptrace, when a simple,
> localized and self contained solution like seccomp is available.

Well, seccomp is also getting very little testing, when ptrace gets a
lot of testing; I know that seccomp is simple, but I believe testing
coverage still make ptrace better choice.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
