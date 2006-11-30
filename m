Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031402AbWK3UgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031402AbWK3UgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031376AbWK3UgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:36:07 -0500
Received: from smtp17.orange.fr ([193.252.23.111]:43972 "EHLO
	smtp-msa-out17.orange.fr") by vger.kernel.org with ESMTP
	id S1031402AbWK3UgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:36:05 -0500
X-ME-UUID: 20061130203603881.D720970000D9@mwinf1703.orange.fr
Subject: 2.6.19-rt1 Bug
From: joel silvestre <j.silvestre@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 30 Nov 2006 21:36:03 +0100
Message-Id: <1164918963.3923.77.camel@zordi>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

comes from an Intel core duo laptop running
kernel-rt-2.6.19-1.rt1.0001.i686.rpm on Fedora 6.

joël

Nov 30 21:24:40 localhost kernel: BUG: scheduling with irqs disabled:
IRQ 9/0x00000001/77
Nov 30 21:24:40 localhost kernel: caller is rt_spin_lock_slowlock
+0x106/0x18a
Nov 30 21:24:40 localhost kernel:  [<c0104e1b>] dump_trace+0x64/0x1cc
Nov 30 21:24:40 localhost kernel:  [<c0104f9c>] show_trace_log_lvl
+0x19/0x2e
Nov 30 21:24:40 localhost kernel:  [<c01052e0>] show_trace+0x12/0x14
Nov 30 21:24:40 localhost kernel:  [<c01052f9>] dump_stack+0x17/0x19
Nov 30 21:24:40 localhost kernel:  [<c032c0ac>] schedule+0x71/0xe7
Nov 30 21:24:40 localhost kernel:  [<c032cc04>] rt_spin_lock_slowlock
+0x106/0x18a
Nov 30 21:24:40 localhost kernel:  [<c032d0a5>] rt_spin_lock+0x20/0x22
Nov 30 21:24:40 localhost kernel:  [<c0123267>] __wake_up+0x13/0x50
Nov 30 21:24:40 localhost kernel:  [<c0230bd4>] acpi_ec_gpe_handler
+0x54/0x8b
Nov 30 21:24:40 localhost kernel:  [<c021dff5>] acpi_ev_gpe_dispatch
+0x68/0x163
Nov 30 21:24:40 localhost kernel:  [<c021e189>] acpi_ev_gpe_detect
+0x99/0xe0
Nov 30 21:24:40 localhost kernel:  [<c021c791>]
acpi_ev_sci_xrupt_handler+0x15/0x1d
Nov 30 21:24:40 localhost kernel:  [<c0217530>] acpi_irq+0xe/0x18
Nov 30 21:24:40 localhost kernel:  [<c015925b>] handle_IRQ_event
+0x45/0xc1
Nov 30 21:24:40 localhost kernel:  [<c01598ce>] thread_simple_irq
+0x39/0x6c
Nov 30 21:24:40 localhost kernel:  [<c0159d11>] do_irqd+0xdd/0x298
Nov 30 21:24:40 localhost kernel:  [<c013a8cf>] kthread+0xc2/0xef
Nov 30 21:24:40 localhost kernel:  [<c0104b5b>] kernel_thread_helper
+0x7/0x10
Nov 30 21:24:40 localhost kernel:  =======================
Nov 30 21:24:41 localhost kernel: BUG: scheduling while atomic: IRQ
9/0x00000001/77, CPU#1
Nov 30 21:24:41 localhost kernel:  [<c0104e1b>] dump_trace+0x64/0x1cc
Nov 30 21:24:41 localhost kernel:  [<c0104f9c>] show_trace_log_lvl
+0x19/0x2e
Nov 30 21:24:41 localhost kernel:  [<c01052e0>] show_trace+0x12/0x14
Nov 30 21:24:41 localhost kernel:  [<c01052f9>] dump_stack+0x17/0x19
Nov 30 21:24:41 localhost kernel:  [<c032b204>] __schedule+0x84/0xd91
Nov 30 21:24:41 localhost kernel:  [<c032c106>] schedule+0xcb/0xe7
Nov 30 21:24:41 localhost kernel:  [<c032cc04>] rt_spin_lock_slowlock
+0x106/0x18a
Nov 30 21:24:41 localhost kernel:  [<c032d0a5>] rt_spin_lock+0x20/0x22
Nov 30 21:24:41 localhost kernel:  [<c0123267>] __wake_up+0x13/0x50
Nov 30 21:24:41 localhost kernel:  [<c0230bd4>] acpi_ec_gpe_handler
+0x54/0x8b
Nov 30 21:24:41 localhost kernel:  [<c021dff5>] acpi_ev_gpe_dispatch
+0x68/0x163
Nov 30 21:24:41 localhost kernel:  [<c021e189>] acpi_ev_gpe_detect
+0x99/0xe0
Nov 30 21:24:41 localhost kernel:  [<c021c791>]
acpi_ev_sci_xrupt_handler+0x15/0x1d
Nov 30 21:24:41 localhost kernel:  [<c0217530>] acpi_irq+0xe/0x18
Nov 30 21:24:41 localhost kernel:  [<c015925b>] handle_IRQ_event
+0x45/0xc1
Nov 30 21:24:41 localhost kernel:  [<c01598ce>] thread_simple_irq
+0x39/0x6c
Nov 30 21:24:41 localhost kernel:  [<c0159d11>] do_irqd+0xdd/0x298
Nov 30 21:24:41 localhost kernel:  [<c013a8cf>] kthread+0xc2/0xef
Nov 30 21:24:41 localhost kernel:  [<c0104b5b>] kernel_thread_helper
+0x7/0x10
Nov 30 21:24:41 localhost kernel:  =======================


