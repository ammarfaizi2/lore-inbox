Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284195AbRLKXeP>; Tue, 11 Dec 2001 18:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284197AbRLKXd7>; Tue, 11 Dec 2001 18:33:59 -0500
Received: from corp.tivoli.com ([216.140.178.60]:55256 "EHLO corp.tivoli.com")
	by vger.kernel.org with ESMTP id <S284182AbRLKXdo>;
	Tue, 11 Dec 2001 18:33:44 -0500
Message-ID: <3C169991.454A7E49@mail.com>
Date: Tue, 11 Dec 2001 17:41:05 -0600
From: Brian Horton <go_gators@mail.com>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to debug a deadlock'ed kernel?
In-Reply-To: <3C166540.DC0BDBEE@mail.com> <3C167D98.90651C10@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll try the nmi_watchdog option out. It appears to not be in
the 2.2.14 kernel, but is in a 2.2.19 kernel that I have from RedHat.

Is there a version of kgdb that works with 2.2.x kernels? I only see 2.4
kernels on the web page (http://kgdb.sourceforge.net)

thx.bri.

george anzinger wrote:
> 
> Brian Horton wrote:
> >
> > Anyone got any good tips on how to debug a SMP system that is locked up
> > in a deadlock situation in the kernel? I'm working on a kernel module,
> > and after some number of hours of stress testing, the box locks up. None
> > of the sysrq options show anything on the display, though the reBoot
> > option does reboot the system. RedHat 6.2 and its 2.2.14 kernel. Doesn't
> > hang for me on 2.4, so I need to debug it here...
> >
> > Any hints?
> 
> First read about the NMI boot option in Documentation/nmi_watchdog.txt.
> If you have this turned on and are not oopsing, then the timer (at
> least) is interrupting.  The next step I would take would be to used
> either kdb (no experience) or kgdb.  I have my own version of this if
> you are interested.  It does, however, require an RS232 (serial)
> connection to a host machine.
> 
> I don't know about kdb, but kgdb (my version) uses the NMI to trap the
> other cpus and also traps NMIs on the way to oopsing.
> --
> George           george@mvista.com
> High-res-timers: http://sourceforge.net/projects/high-res-timers/
> Real time sched: http://sourceforge.net/projects/rtsched/
