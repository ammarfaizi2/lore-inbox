Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSJRTdg>; Fri, 18 Oct 2002 15:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSJRTdg>; Fri, 18 Oct 2002 15:33:36 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64006 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265321AbSJRTd3>; Fri, 18 Oct 2002 15:33:29 -0400
Date: Fri, 18 Oct 2002 15:39:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 IO-APIC bug and spinlock deadlock
In-Reply-To: <20021017033302.GP8159@redhat.com>
Message-ID: <Pine.LNX.3.96.1021018153513.23760B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Doug Ledford wrote:

> IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
> fails (does *everyone* run SMP or at least UP + APIC now?)
> 
> spinlock deadlock: run an smp kernel on a up machine.  On mine here all I 
> have to do is try to boot to multiuser mode, it won't make it through the 
> startup scripts before it locks up by trying to reenter common_interrupt 
> on the only CPU.  Seems like an SMP kernel on UP hardware doesn't disable 
> interrupts properly maybe?  I get task lists via alt-sysreq when the 
> machine should be hardlocked I think.  Anyway, this is what has been 
> tricking me into thinking I had an IDE problem.  IDE is innocent, it's the 
> core interrupt handling code.

Doug, I noted a similar bug back about 2.5.38, which went away if I boot
the SMP kernel on uni with "nosmp" in the boot parameters. If you are
curious I'd love to know if that's related, and I'm sure someone looking
at the problem would like to know as well.

The 2.4 kernels seem fine in that regard, I did a test the hard way, when
I got a batch of Xeons with the lifespan of a mayfly. After one died and
the system was rebooted every one came up cleanly with only one CPU.
However, most of the SMP hardware was still there, and I boot "noapic"
because it seems to help uptime.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

