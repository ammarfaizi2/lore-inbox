Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284009AbRLKVm6>; Tue, 11 Dec 2001 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284088AbRLKVms>; Tue, 11 Dec 2001 16:42:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:15610 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S284079AbRLKVmo>; Tue, 11 Dec 2001 16:42:44 -0500
Message-ID: <3C167D98.90651C10@mvista.com>
Date: Tue, 11 Dec 2001 13:41:44 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Horton <go_gators@mail.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to debug a deadlock'ed kernel?
In-Reply-To: <3C166540.DC0BDBEE@mail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Horton wrote:
> 
> Anyone got any good tips on how to debug a SMP system that is locked up
> in a deadlock situation in the kernel? I'm working on a kernel module,
> and after some number of hours of stress testing, the box locks up. None
> of the sysrq options show anything on the display, though the reBoot
> option does reboot the system. RedHat 6.2 and its 2.2.14 kernel. Doesn't
> hang for me on 2.4, so I need to debug it here...
> 
> Any hints?

First read about the NMI boot option in Documentation/nmi_watchdog.txt. 
If you have this turned on and are not oopsing, then the timer (at
least) is interrupting.  The next step I would take would be to used
either kdb (no experience) or kgdb.  I have my own version of this if
you are interested.  It does, however, require an RS232 (serial)
connection to a host machine.

I don't know about kdb, but kgdb (my version) uses the NMI to trap the
other cpus and also traps NMIs on the way to oopsing.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
