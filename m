Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUGBSTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUGBSTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGBSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:19:14 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:43213 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S264762AbUGBSS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:18:57 -0400
Subject: 2.6.7-mm5 - more ACPI/IRQ badness?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040630172656.6949ec60.akpm@osdl.org>
References: <20040630172656.6949ec60.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1088792436.11320.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Jul 2004 20:20:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the issues with my EHCI controller I now hit another related
problem. This time the IRQ of my onboard ethernet controller is being
silenced. It happened when I removed the 3w-9xxx module which share
interrupts. I tried bringing the ethernet connection back to live by
doing a rmmod & insmod but that brought another 'Disabling IRQ..'

<snip>
Synchronizing SCSI cache for disk sde:
FAILED
  status = 0, message = 00, host = 1, driver = 00
  <4>3w-9xxx: Shutting down host 1.
3w-9xxx: Shutdown complete.
irq 22: nobody cared!
 [<c0108106>] __report_bad_irq+0x2a/0x8b
 [<c01081f0>] note_interrupt+0x6f/0x9f
 [<c0108473>] do_IRQ+0x10c/0x10e
 [<c0106850>] common_interrupt+0x18/0x20
handlers:
[<f8a646f6>] (SkGeIsrOnePort+0x0/0x176 [sk98lin])
Disabling IRQ #22
eth0: network connection down
Badness in remove_proc_entry at fs/proc/generic.c:681
 [<c0189e18>] remove_proc_entry+0xfa/0x134
 [<f8a814eb>] skge_cleanup_module+0xc3/0x1c7 [sk98lin]
 [<c01354d6>] __try_stop_module+0x0/0x53
 [<c0132c6b>] sys_delete_module+0x14f/0x1a0
 [<c014c798>] do_munmap+0x126/0x15c
 [<c0105e91>] sysenter_past_esp+0x52/0x71
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
irq 22: nobody cared!
 [<c0108106>] __report_bad_irq+0x2a/0x8b
 [<c01081f0>] note_interrupt+0x6f/0x9f
 [<c0108473>] do_IRQ+0x10c/0x10e
 [<c0106850>] common_interrupt+0x18/0x20
 [<c010401e>] default_idle+0x0/0x2c
 [<c0104047>] default_idle+0x29/0x2c
 [<c01040b0>] cpu_idle+0x33/0x3c
 [<c031684b>] start_kernel+0x1a0/0x1dd
 [<c0316309>] unknown_bootoption+0x0/0x149
handlers:
[<f8a636f6>] (SkGeIsrOnePort+0x0/0x176 [sk98lin])
Disabling IRQ #22

Jurgen


