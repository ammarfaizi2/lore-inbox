Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967489AbWK2RQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967489AbWK2RQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967486AbWK2RQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:16:50 -0500
Received: from smtp20.orange.fr ([80.12.242.27]:9516 "EHLO
	smtp-msa-out20.orange.fr") by vger.kernel.org with ESMTP
	id S967489AbWK2RQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:16:49 -0500
X-ME-UUID: 20061129171648403.6291F1C0007B@mwinf2007.orange.fr
Subject: 2.6.19-rc6-rt9
From: joel silvestre <j.silvestre@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 29 Nov 2006 18:16:47 +0100
Message-Id: <1164820607.3923.50.camel@zordi>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

down is an excerpt from dmesg. 
Comes from an Intel core duo laptop running
kernel-rt-2.6.18-3.rt9.0001.i686.rpm and Fedora 6.
This kernel boot and run.

joël

BUG: scheduling with irqs disabled: IRQ 9/0x00000001/77
caller is rt_spin_lock_slowlock+0x106/0x18a
 [<c0104e1b>] dump_trace+0x64/0x1cc
 [<c0104f9c>] show_trace_log_lvl+0x19/0x2e
 [<c01052e0>] show_trace+0x12/0x14
 [<c01052f9>] dump_stack+0x17/0x19
 [<c0334b5b>] schedule+0x71/0xe7
 [<c03356b3>] rt_spin_lock_slowlock+0x106/0x18a
 [<c0335b55>] rt_spin_lock+0x20/0x22
 [<c0137e1a>] __queue_work+0xf/0x4e
 [<c0138511>] queue_work+0x70/0x7f
 [<c0217e46>] acpi_os_execute+0x62/0x7b
 [<c0230cb3>] acpi_ec_gpe_handler+0x6b/0x8b
 [<c021e0bd>] acpi_ev_gpe_dispatch+0x68/0x163
 [<c021e251>] acpi_ev_gpe_detect+0x99/0xe0
 [<c021c859>] acpi_ev_sci_xrupt_handler+0x15/0x1d
 [<c02175f4>] acpi_irq+0xe/0x18
 [<c0159387>] handle_IRQ_event+0x45/0xc1
 [<c01599fa>] thread_simple_irq+0x39/0x6c
 [<c0159e3d>] do_irqd+0xdd/0x298
 [<c013a9bf>] kthread+0xc2/0xef
 [<c0104b5b>] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:

 [<c0104f9c>] show_trace_log_lvl+0x19/0x2e
 [<c01052e0>] show_trace+0x12/0x14
 [<c01052f9>] dump_stack+0x17/0x19
 [<c0334b5b>] schedule+0x71/0xe7
 [<c03356b3>] rt_spin_lock_slowlock+0x106/0x18a
 [<c0335b55>] rt_spin_lock+0x20/0x22
 [<c0137e1a>] __queue_work+0xf/0x4e
 [<c0138511>] queue_work+0x70/0x7f
 [<c0217e46>] acpi_os_execute+0x62/0x7b
 [<c0230cb3>] acpi_ec_gpe_handler+0x6b/0x8b
 [<c021e0bd>] acpi_ev_gpe_dispatch+0x68/0x163
 [<c021e251>] acpi_ev_gpe_detect+0x99/0xe0
 [<c021c859>] acpi_ev_sci_xrupt_handler+0x15/0x1d
 [<c02175f4>] acpi_irq+0xe/0x18
 [<c0159387>] handle_IRQ_event+0x45/0xc1
 [<c01599fa>] thread_simple_irq+0x39/0x6c
 [<c0159e3d>] do_irqd+0xdd/0x298
 [<c013a9bf>] kthread+0xc2/0xef
 [<c0104b5b>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: IRQ 9/0x00000001/77, CPU#0
 [<c0104e1b>] dump_trace+0x64/0x1cc
 [<c0104f9c>] show_trace_log_lvl+0x19/0x2e
 [<c01052e0>] show_trace+0x12/0x14
 [<c01052f9>] dump_stack+0x17/0x19
 [<c0333cac>] __schedule+0x84/0xd98
 [<c0334bb5>] schedule+0xcb/0xe7
 [<c03356b3>] rt_spin_lock_slowlock+0x106/0x18a
 [<c0335b55>] rt_spin_lock+0x20/0x22
 [<c0137e1a>] __queue_work+0xf/0x4e
 [<c0138511>] queue_work+0x70/0x7f
 [<c0217e46>] acpi_os_execute+0x62/0x7b
 [<c0230cb3>] acpi_ec_gpe_handler+0x6b/0x8b
 [<c021e0bd>] acpi_ev_gpe_dispatch+0x68/0x163
 [<c021e251>] acpi_ev_gpe_detect+0x99/0xe0
 [<c021c859>] acpi_ev_sci_xrupt_handler+0x15/0x1d
 [<c02175f4>] acpi_irq+0xe/0x18
 [<c0159387>] handle_IRQ_event+0x45/0xc1
 [<c01599fa>] thread_simple_irq+0x39/0x6c
 [<c0159e3d>] do_irqd+0xdd/0x298
 [<c013a9bf>] kthread+0xc2/0xef
 [<c0104b5b>] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:

 [<c0104f9c>] show_trace_log_lvl+0x19/0x2e
 [<c01052e0>] show_trace+0x12/0x14
 [<c01052f9>] dump_stack+0x17/0x19
 [<c0333cac>] __schedule+0x84/0xd98
 [<c0334bb5>] schedule+0xcb/0xe7
 [<c03356b3>] rt_spin_lock_slowlock+0x106/0x18a
 [<c0335b55>] rt_spin_lock+0x20/0x22
 [<c0137e1a>] __queue_work+0xf/0x4e
 [<c0138511>] queue_work+0x70/0x7f
 [<c0217e46>] acpi_os_execute+0x62/0x7b
 [<c0230cb3>] acpi_ec_gpe_handler+0x6b/0x8b
 [<c021e0bd>] acpi_ev_gpe_dispatch+0x68/0x163
 [<c021e251>] acpi_ev_gpe_detect+0x99/0xe0
 [<c021c859>] acpi_ev_sci_xrupt_handler+0x15/0x1d
 [<c02175f4>] acpi_irq+0xe/0x18
 [<c0159387>] handle_IRQ_event+0x45/0xc1
 [<c01599fa>] thread_simple_irq+0x39/0x6c
 [<c0159e3d>] do_irqd+0xdd/0x298
 [<c013a9bf>] kthread+0xc2/0xef
 [<c0104b5b>] kernel_thread_helper+0x7/0x10
 =======================


