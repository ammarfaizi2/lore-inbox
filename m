Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUJKOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUJKOxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUJKOwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:52:14 -0400
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:45696 "EHLO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with ESMTP
	id S269024AbUJKOvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:51:05 -0400
Date: Mon, 11 Oct 2004 16:51:04 +0200
From: Vitez Gabor <vitezg@niif.hu>
To: linux-kernel@vger.kernel.org
Cc: Manfred Spraul <manfred@colorfullife.com>
Subject: forcedeth: "received irq with unknown events 0x1"
Message-ID: <20041011145104.GA9494@swszl.szkp.uni-miskolc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my forcedeth driver said:

eth1: received irq with unknown events 0x1. Please report

It happened, when I tried to connect two machines with straight ethernet
cable. 

One of the machines is a Dell Poweredge 400SC, with an intel E1000 card, 
the other is a home-made one, with nvidia nforce2 chipset based motherboard,
integrated nvidia ethernet, and a 3com 905C network card. 

When I connect the Dell machine to the nvidia ethernet card, I get the
"unknown events" warning, and the E1000's driver reports that the link is
down. However when I connect the E1000 and the 3com card, everything works
fine. Both kernels are vanilla 2.4.27.

lspci of the nvidia ethernet card:

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller
(rev a1)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 570c
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
        Memory at e1086000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at e000 [size=8]
        Capabilities: <available only to root>


lspci of the E1000 card:

02:0c.0 Ethernet controller: Intel Corp.: Unknown device 100e (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0156
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
        Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at db40 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] #07 [0002]
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-



	regards
		Gabor
