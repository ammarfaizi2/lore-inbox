Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTI3Kkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbTI3Kkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:40:40 -0400
Received: from main.gmane.org ([80.91.224.249]:62870 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261282AbTI3Kkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:40:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: Re: irq 12: nobody cared! (2.6.0-test6)
Date: Tue, 30 Sep 2003 10:38:48 +0000 (UTC)
Message-ID: <slrnbnina1.5q2.usenet.2117@home.andreas-s.net>
References: <Pine.GSO.4.44.0309290947230.9442-100000@math.ut.ee> <1064830579.1389.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Mon, 2003-09-29 at 08:56, Meelis Roos wrote:
>> This is Linux 2.6.0-test6 on a PC with VIA KT133A chipset (MSI MS-6330
>> mainboard), PS/2 keyboard, USB mouse. In test5 it hung on boot just
>> after printing
>> mice: PS/2 mouse device common for all mice
>> input: PC Speaker
>> 
>> In 2.6.0-test6, it spits out several "irq 12: nobody cared!" messages
>> with backtraces and then continues as if nothing happened. The system
>> works fine, PS/2 keyboard and USB mouse both work too. Similar
>> configuration (PS/2 keyboard + USB mouse) works fine on an i815 chipset
>> computer.
>
> Have you tried with 2.6.0-test6-mm1? It includes a fix for ACPI PCI
> routing which may help in your case.

I get the following message at boot with 2.6.0-test6-mm1:
=========================================================

irq 12: nobody cared!
Call Trace:
 [<c010b6ca>] __report_bad_irq+0x2a/0x90
 [<c010b7c0>] note_interrupt+0x70/0xb0
 [<c010bab0>] do_IRQ+0x130/0x140
 [<c0109c88>] common_interrupt+0x18/0x20
 [<c0120b90>] do_softirq+0x40/0xa0
 [<c010ba86>] do_IRQ+0x106/0x140
 [<c0109c88>] common_interrupt+0x18/0x20
 [<c010c03e>] setup_irq+0x9e/0xf0
 [<c027c5e0>] i8042_interrupt+0x0/0x190
 [<c010bb68>] request_irq+0xa8/0xe0
 [<c03c5e3d>] i8042_check_mux+0x3d/0x170
 [<c027c5e0>] i8042_interrupt+0x0/0x190
 [<c03c63a5>] i8042_init+0x115/0x150
 [<c03ae74c>] do_initcalls+0x2c/0xa0
 [<c012ca8f>] init_workqueues+0xf/0x30
 [<c01050d2>] init+0x32/0x140
 [<c01050a0>] init+0x0/0x140
 [<c0107149>] kernel_thread_helper+0x5/0xc

handlers:
[<c027c5e0>] (i8042_interrupt+0x0/0x190)
Disabling IRQ #12
irq 12: nobody cared!
Call Trace:
 [<c010b6ca>] __report_bad_irq+0x2a/0x90
 [<c010b7c0>] note_interrupt+0x70/0xb0
 [<c010bab0>] do_IRQ+0x130/0x140
 [<c0109c88>] common_interrupt+0x18/0x20
 [<c0120b90>] do_softirq+0x40/0xa0
 [<c010ba86>] do_IRQ+0x106/0x140
 [<c0109c88>] common_interrupt+0x18/0x20
 [<c010c03e>] setup_irq+0x9e/0xf0
 [<c027c5e0>] i8042_interrupt+0x0/0x190
 [<c010bb68>] request_irq+0xa8/0xe0
 [<c03c5fa5>] i8042_check_aux+0x35/0x160
 [<c027c5e0>] i8042_interrupt+0x0/0x190
 [<c03c637c>] i8042_init+0xec/0x150
 [<c03ae74c>] do_initcalls+0x2c/0xa0
 [<c012ca8f>] init_workqueues+0xf/0x30
 [<c01050d2>] init+0x32/0x140
 [<c01050a0>] init+0x0/0x140
 [<c0107149>] kernel_thread_helper+0x5/0xc

handlers:
[<c027c5e0>] (i8042_interrupt+0x0/0x190)
Disabling IRQ #12

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net

