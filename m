Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269629AbUJAANq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269629AbUJAANq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUJAANq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:13:46 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:35978 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S269629AbUJAANo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:13:44 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: USB storage crash report in 2.6 SMP
Date: Thu, 30 Sep 2004 23:54:45 GMT
Message-ID: <04E3EF912@server5.heliogroup.fr>
X-Mailer: Pliant 92
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copying a large amount of datas (several gigabytes) between two USB 2.0 attached
disks will crash any Linux 2.6 SMP kernel, including 2.6.9-rc3.

The stack report is:
qh_completions 0x7B/0x118 [ehci_hcd]
scan_async
ehci_work
echi_irq
handle_IRQ_event
commnon_interrupt
default_idle
default_idle
cpu_idle

The crash will append on any attempt to copy something like 100 GB.
Copying something like 1 GB or less works nicely.
Switching to an UP kernel solves the problem.
Switching to a 2.4 kernel solves the problem.
I tested it on two different machines, with two different disks sets.

