Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbTFEOGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbTFEOGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:06:39 -0400
Received: from pusa.informat.uv.es ([147.156.10.98]:23683 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S264685AbTFEOGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:06:37 -0400
Date: Thu, 5 Jun 2003 16:20:05 +0200
To: linux-kernel@vger.kernel.org
Subject: GE traffic statistics (/proc/net/dev)
Message-ID: <20030605142005.GA9292@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I have a GE NIC card working in receive only mode capturing all traffic at
80Gbps in a 2-way SMP Pentium-III system.

I found very extrange that, for this device, stats on /proc/net/dev updates 
each second (more or less), that is, not in sub-second intervals. Again note
this only happens for this device and not for other NIC card (Fast-Ethernet 
card, e100).

I'm quite sure that the nic is receiving the traffic smootly, 
because interrupts are distributed smoothly in the time in /proc/interrupts
(I talk about sub second intervals here). Tthe GE card makes around 10000 
ints/second. 

Also I think packets are forwarded to the CPU smoothly (not in chunks each second)
because measurements of timestamps and RTT calculations I made.

I'm curious why just this device updates stats this way.

I'm running vanilla 2.4.20


Any comment will be greatly appreciated

Thanks in advance


	Ulisses

some aditional info about the GE nic

00:0b.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
        Subsystem: 3Com Corporation 3C996B-T 1000BaseTX
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
        Memory at f4000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: <available only to root>

this card is working in a 32bit bus at 33Mhz

eth1: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:04:76:f6:8a:a0
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is off for TX and off for RX.

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
