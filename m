Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTEZRuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTEZRuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:50:35 -0400
Received: from pointblue.com.pl ([62.89.73.6]:58641 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261968AbTEZRtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:49:51 -0400
Subject: OUPS 2.5.69-bk19 sonypi irq 11: nobody cared!
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: stelian@popies.net
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053971418.2003.13.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 18:50:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq 11: nobody cared!

Call Trace:
 [<c010cb90>] handle_IRQ_event+0x90/0x100
 [<c010cdd1>] do_IRQ+0x91/0x120
 [<c790f9c0>] +0x0/0x18 [sonypi]
 [<c790f9ec>] sonypi_type1_irq_list+0x0/0x10 [sonypi]
 [<c010b388>] common_interrupt+0x18/0x20
 [<c790f9c0>] +0x0/0x18 [sonypi]
 [<c790f9ec>] sonypi_type1_irq_list+0x0/0x10 [sonypi]
 [<c790c409>] sonypi_call2+0x29/0xf0 [sonypi]
 [<c790d54e>] sonypi_probe+0x13e/0x460 [sonypi]
 [<c790da96>] +0x2a/0xb4 [sonypi]
 [<c790c8d0>] sonypi_irq+0x0/0x2a0 [sonypi]
 [<c790fd00>] +0x0/0x200 [sonypi]
 [<c030206f>] pci_find_device+0x2f/0x40
 [<c790fd00>] +0x0/0x200 [sonypi]
 [<c78fe030>] +0x30/0x3b [sonypi]
 [<c013509f>] sys_init_module+0xff/0x210
 [<c790fd00>] +0x0/0x200 [sonypi]
 [<c010b21b>] syscall_call+0x7/0xb


handlers:
[<c790c8d0>] (sonypi_irq+0x0/0x2a0 [sonypi])
sonypi: Sony Programmable I/O Controller Driver v1.18.
sonypi: detected type1 model, verbose = 0, fnkeyinit = off, camera =
off, compat = off, ma
sk = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x10c0, port2=0x10c4
sonypi: device allocated minor is 63
irq 11: nobody cared!
Call Trace:
 [<c010cb90>] handle_IRQ_event+0x90/0x100
 [<c010cdd1>] do_IRQ+0x91/0x120
 [<c0105000>] _stext+0x0/0x60
 [<c010b388>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x60
 [<c0320014>] acpi_processor_idle+0xd4/0x1d0
 [<c031ff40>] acpi_processor_idle+0x0/0x1d0
 [<c031ff40>] acpi_processor_idle+0x0/0x1d0
 [<c0105000>] _stext+0x0/0x60
 [<c01090e9>] cpu_idle+0x39/0x50
 [<c066c718>] start_kernel+0x148/0x150
 [<c066c480>] unknown_bootoption+0x0/0x120

handlers:
[<c790c8d0>] (sonypi_irq+0x0/0x2a0 [sonypi])
Sony VAIO Jog Dial installed.
Linux video capture interface: v1.00
meye: using 2 buffers with 600k (1200k total) for capture
meye: Motion Eye Camera Driver v1.6.
meye: mchip KL5A72002 rev. 1, base fc00d800, irq 9

but they seem to work fine :]


-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

