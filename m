Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbTHJSem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270617AbTHJSem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:34:42 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:57545 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP id S270608AbTHJSek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:34:40 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 does Oops: as soon as penguin is onscreen
Date: Sun, 10 Aug 2003 14:34:38 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101434.38753.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [151.205.63.55] at Sun, 10 Aug 2003 13:34:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops: 0000 [#1]
cpu:  0
EIP:  0060:[<c02056ac>]	Not tainted
EFLAGS: 0010286
EID: is at acpi_register_driver+0x38/0x62
eax: c04ac32c	ebx: 00000000	ecx: c03dd5450	edx: 00000296
esi: c040ee018	edi: 00000000	ebp: c152ff90	esp: c152ff84
ds:  007b	es: 00yb	ss: 0068
process_swapper pid:1, threadinfo=c152e0000 task=c152d880
stack: c0496414 00000001 00000000 c1529ffc c01ea955 c040ec18 c152ffa8 c01e8c29
       c0496414 c152ffb8 c047c029 c03a0e80 c03964d4 c046c77c c152ffcc 
       c012d732 c038887d c152e000 00000000 c152ffec c0105066 00000000 c0105070
call trace:
[<c01ea955>] acpiphp_glue_init+0x025/0x030
[<c01e8c29>] init_acpi+0x9/0x30
[<c047c029>] acpiphp_init+0x29/0x40
[<c046c77e>] do_initcalls+0x2c/0xa0
[<c012d732>] init_workqueues+0x12/0x60
[<c01050a6>] init+0x36/0x190
[<c0105070>] init+0x0/0x190
[<c0107259>] kernel_thread_helper+0x5/0xc
code: 8b 03 0f 18 00 90 81 ff 24 03 4a 00 74 18 ff 73 08 ff 56 04
<0> kernel panic:Attempted to kill init!
------------
It took me about 20 minutes and 3 reboots to get all that because 
the screen kept blanking, and I see that I missed getting one
sequence of the stack trace in the 2nd line.  Minor squawk,

but what have I done wrong other than turn acpi on, which works
just fine for 2.4.22-rc2?

Here is a grep of the .config for ACPI
# Power management options (ACPI, APM)
# ACPI Support
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_SERIAL_8250_ACPI=y

Thanks for any hints you can throw my way.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

