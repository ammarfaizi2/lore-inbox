Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbUKREDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUKREDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUKREDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:03:30 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:39866 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262491AbUKREC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:02:56 -0500
From: kernel-stuff@comcast.net
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: X86_64: Many Lost ticks
Date: Thu, 18 Nov 2004 04:02:55 +0000
Message-Id: <111820040402.18259.419C1EEE000EC75D00004753220075115000009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 11 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a X86_64 laptop (Compaq Presario R3240) with all BIOS updates in place. I routinely get the "Warning : many lost ticks" message in dmesg. 

I booted with report_lost_ticks after seeing the source of arch/x86_86/kernel/time.c:handle_lost_ticks and it reported that rip was at acpi_ec_read most of the times.

Why is this warning caused and what's the effect? In handle_lost_ticks, it does not seem to compensate for the lost ticks..

Parry. 

dmesg with report_lost_ticks=1
========================================================
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
i2c /dev entries driver
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 3 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
eth0: no IPv6 routers present
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
input: PS/2 Generic Mouse on isa0060/serio4
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 2 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 2 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 2 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 2 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 2 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x41/0xa2
time.c: Lost 1 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 5 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 4 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
time.c: Lost 5 timer tick(s)! rip acpi_ec_read+0xce/0xed)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x41/0xa2)
