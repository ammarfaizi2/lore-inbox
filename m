Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbTIKEte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbTIKEte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:49:34 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:7940 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S266067AbTIKEtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:49:31 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Date: Thu, 11 Sep 2003 12:45:47 +0800
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0309091726050.695-100000@cherise>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111245.49449.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied test5-pm1.diff to 2.6.0-test5

patch creates drivers/cpufreq/cpufreq_powersave.c, which _is_ already in -test5 

S3/mem PCI LNK's do not resume.

/proc/acpi/alarm hang on wakeup

echo multiple times > /proc/acpi/alarm

Sep 11 12:41:29 mhfl2 kernel: irq 9: nobody cared!
Sep 11 12:41:29 mhfl2 kernel: Call Trace:
Sep 11 12:41:29 mhfl2 kernel:  [<c010c35b>] __report_bad_irq+0x2b/0x90
Sep 11 12:41:29 mhfl2 kernel:  [<c010c363>] __report_bad_irq+0x33/0x90
Sep 11 12:41:29 mhfl2 kernel:  [<c010c438>] note_interrupt+0x50/0x78
Sep 11 12:41:29 mhfl2 kernel:  [<c010c5b2>] do_IRQ+0x96/0xf4
Sep 11 12:41:29 mhfl2 kernel:  [<c010afe8>] common_interrupt+0x18/0x20
Sep 11 12:41:29 mhfl2 kernel:  [<c011de78>] do_softirq+0x48/0xb0
Sep 11 12:41:29 mhfl2 kernel:  [<c010c600>] do_IRQ+0xe4/0xf4
Sep 11 12:41:29 mhfl2 kernel:  [<c010afe8>] common_interrupt+0x18/0x20
Sep 11 12:41:29 mhfl2 kernel:  [<c01e305d>] acpi_os_write_port+0x35/0x50
Sep 11 12:41:29 mhfl2 kernel:  [<c01f852e>] acpi_hw_low_level_write+0x7e/0x11e
Sep 11 12:41:29 mhfl2 kernel:  [<c01f827d>] acpi_hw_register_write+0xb9/0x1c0
Sep 11 12:41:29 mhfl2 kernel:  [<c01f7f96>] acpi_set_register+0x262/0x2d0
Sep 11 12:41:29 mhfl2 kernel:  [<c020cbac>] acpi_system_write_alarm+0x4f0/0x53c
Sep 11 12:41:30 mhfl2 kernel:  [<c0150000>] put_dirty_page+0x68/0xec
Sep 11 12:41:30 mhfl2 kernel:  [<c0147dae>] vfs_write+0x9e/0xd0
Sep 11 12:41:30 mhfl2 kernel:  [<c0147e60>] sys_write+0x30/0x50
Sep 11 12:41:30 mhfl2 kernel:  [<c010adc7>] syscall_call+0x7/0xb
Sep 11 12:41:30 mhfl2 kernel: 
Sep 11 12:41:30 mhfl2 kernel: handlers:
Sep 11 12:41:30 mhfl2 kernel: [<c01e2ebc>] (acpi_irq+0x0/0x1c)
Sep 11 12:41:30 mhfl2 kernel: Disabling IRQ #9

Regards
Michael


