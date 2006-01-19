Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWASJaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWASJaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWASJaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:30:39 -0500
Received: from mailout1.pacific.net.au ([61.8.0.84]:54433 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S1751291AbWASJaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:30:39 -0500
Date: Thu, 19 Jan 2006 20:30:28 +1100
Message-Id: <200601190930.k0J9US4P009504@typhaon.pacific.net.au>
From: "David Luyer" <david@luyer.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: SKY2 driver - version 0.13 - buggy but working
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your new SKY2 driver in the latest 2.6.16-rc1 snapshots does millions
of printk()s (approximately 230,000 per second) ... but works!

Motherboard: A7V-E SE (onboard Marvel GE)
OS: Linux current snapshot (2.6.16-rc1-g0f36b018), 32-bit on AMD64
PCI options: ACPI, PCI, PCI Express, MSI enabled

dmesg|egrep 'sky2|messages suppressed':

sky2 v0.13 addr 0xdc000000 irq 66 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:13:d4:f6:be:52
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
sky2 0000:05:00.0: pci express error (0x0)
printk: 1144326 messages suppressed.
sky2 0000:05:00.0: pci express error (0x0)
printk: 1141162 messages suppressed.
sky2 0000:05:00.0: pci express error (0x0)
printk: 1122566 messages suppressed.
sky2 0000:05:00.0: pci express error (0x0)
printk: 1125246 messages suppressed.
sky2 0000:05:00.0: pci express error (0x0)
printk: 1124271 messages suppressed.
sky2 0000:05:00.0: pci express error (0x0)
printk: 1130645 messages suppressed.

David.
-- 
Pacific Internet (Australia) Pty Ltd
Business card: http://www.luyer.net/bc.html
Important notice: http://www.pacific.net.au/disclaimer/
