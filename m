Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUFPCgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUFPCgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUFPCgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:36:55 -0400
Received: from 126-129-239-64.tierzero.net ([64.239.129.126]:14799 "EHLO
	kabbalah.com") by vger.kernel.org with ESMTP id S266073AbUFPCgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:36:40 -0400
Subject: getting up Intel gigE 82547GI (8086:1075) crashes kernel
From: Moshe <moshe.gurvich@kabbalah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <1087353399.3534.20.camel@moshe.kci.kabbalah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 15 Jun 2004 19:36:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've got few Dell PE750 boxes with P4HT.
 
Installed Mandrake 10.0 with 2.6.3-smp.
 
This box have 2 onboard nics:
eth0: 82547GI (8086:1075)
eth1: 82541GI (8086:1076)
 
When I try to ifup eth0 it crashes kernel, i can't even toggle NumLock,
when i boot with noapic, i can at least toggle NumLock, but nothing
else.
 
eth1 gets up fine and works perfectly.
 
I've got suggestions to rebuild kernel without acpi, apm, apic.. will it
help?
 
Any others ideas?
Thanks..
 
 # lspci -v:
 01:01.0 Ethernet controller: Intel Corp.: Unknown device 1075
 Subsystem: Dell Computer Corporation: Unknown device 0165
 Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
 Memory at fe1e0000 (32-bit, non-prefetchable) [size=128K]
 I/O ports at ece0 [size=32]
 Capabilities: [dc] Power Management version 2
 
 03:02.0 Ethernet controller: Intel Corp.: Unknown device 1076
 Subsystem: Dell Computer Corporation: Unknown device 0165
 Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 21
 Memory at fdee0000 (32-bit, non-prefetchable) [size=128K]
 I/O ports at dcc0 [size=64]
 Capabilities: [dc] Power Management version 2
 Capabilities: [e4] PCI-X non-bridge device.
 
 # dmesg:
 Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
 Copyright (c) 1999-2004 Intel Corporation.
 PCI: Setting latency timer of device 0000:01:01.0 to 64
 eth0: Intel(R) PRO/1000 Network Connection
 eth1: Intel(R) PRO/1000 Network Connection

