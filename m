Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266171AbUFPFIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUFPFIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 01:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUFPFIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 01:08:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:64475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266171AbUFPFIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 01:08:02 -0400
Date: Tue, 15 Jun 2004 22:03:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Moshe <moshe.gurvich@kabbalah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting up Intel gigE 82547GI (8086:1075) crashes kernel
Message-Id: <20040615220324.1657a4f6.rddunlap@osdl.org>
In-Reply-To: <1087353399.3534.20.camel@moshe.kci.kabbalah.com>
References: <1087353399.3534.20.camel@moshe.kci.kabbalah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004 19:36:39 -0700 Moshe wrote:

| Hi, 
| 
| I've got few Dell PE750 boxes with P4HT.
|  
| Installed Mandrake 10.0 with 2.6.3-smp.
|  
| This box have 2 onboard nics:
| eth0: 82547GI (8086:1075)
| eth1: 82541GI (8086:1076)
|  
| When I try to ifup eth0 it crashes kernel, i can't even toggle NumLock,
| when i boot with noapic, i can at least toggle NumLock, but nothing
| else.
|  
| eth1 gets up fine and works perfectly.
|  
| I've got suggestions to rebuild kernel without acpi, apm, apic.. will it
| help?

You don't have to rebuild the kernel to turn those off -- there
are boot/command line options for them.  See
linux-2.6.x/Documentation/kernel-parameters.txt for info.

E.g.,
acpi=off apm=off noapic

| Any others ideas?
| Thanks..

No serial console or other debugging tool available?

|  # lspci -v:
|  01:01.0 Ethernet controller: Intel Corp.: Unknown device 1075
|  Subsystem: Dell Computer Corporation: Unknown device 0165
|  Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
|  Memory at fe1e0000 (32-bit, non-prefetchable) [size=128K]
|  I/O ports at ece0 [size=32]
|  Capabilities: [dc] Power Management version 2
|  
|  03:02.0 Ethernet controller: Intel Corp.: Unknown device 1076
|  Subsystem: Dell Computer Corporation: Unknown device 0165
|  Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 21
|  Memory at fdee0000 (32-bit, non-prefetchable) [size=128K]
|  I/O ports at dcc0 [size=64]
|  Capabilities: [dc] Power Management version 2
|  Capabilities: [e4] PCI-X non-bridge device.
|  
|  # dmesg:
|  Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
|  Copyright (c) 1999-2004 Intel Corporation.
|  PCI: Setting latency timer of device 0000:01:01.0 to 64
|  eth0: Intel(R) PRO/1000 Network Connection
|  eth1: Intel(R) PRO/1000 Network Connection

--
~Randy
