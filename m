Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263866AbRFISMS>; Sat, 9 Jun 2001 14:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264272AbRFISMH>; Sat, 9 Jun 2001 14:12:07 -0400
Received: from imladris.infradead.org ([194.205.184.45]:16400 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S263866AbRFISLu>;
	Sat, 9 Jun 2001 14:11:50 -0400
Date: Sat, 9 Jun 2001 19:11:48 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Michael McConnell <soruk@eridani.co.uk>
Subject: 2.2.19 DMA problem
Message-ID: <Pine.LNX.4.33.0106091829540.23184-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

A friend of mine is having a problem with the 2.2.19 kernel on one of
his boxes, and has asked for some advice which is beyond my experience
so I'm asking here: Is this a kernel problem or something else?

First, the hardware, as best we can determine:

	Vesa VLB motherboard, model unknown.
	Intel 486dx4/100 stepping 0.
	48 Mb of RAM
	eth0 is an RTL8009 chipset configured for 0x300/IRQ9
	Serial port 0x3f8/4 (16550A) connects to an external modem
	Serial port 0x2f8/3 (16550A) is unused

The boix in question isn't used for compiling, but here's what the
ver_linux script from 2.2.18 produced on it:

	binutils:		2.9.5.0.22
	util-linux:		2.10f
	modutils:		2.3.21
	e2fsprogs:		1.18
	PPP:			2.3.11
	Linux C Library:	2.1.3
	Dynamic Linker (ldd):	2.1.3
	Procps:			2.0.6
	Net-tools:		1.54
	Console-tools:		0.3.3
	Sh-utils:		2.0

The machine that compiled the kernel has:

	Gnu-C:			egcs-2.91.66
	Gnu Make:		3.77
	Binutils:		2.9.1.0.24

The problem machine irregularly spams the following over both the
console and syslog (taken from syslog):

 Q> Jun  9 17:34:04 Doorstep kernel: eth0: DMAing conflict in
 Q>		ne_block_output.[DMAstat:1][irqlock:1][intr:0]
 Q> Jun  9 17:34:04 Doorstep kernel: eth0: DMAing conflict in
 Q>		ne_get_8390_hdr.[DMAstat:1][irqlock:0][intr:1]

When this happens, the spam can be stopped by `ifconfig eth0 down` but
the card is totally dead and can only be restarted by rebooting the
machine.

Can anybody advise on likely solutions, as this is his firewall
gateway machine, so causes quite a bit of inconvenience.

Best wishes from Riley.

