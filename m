Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281708AbRKQHOJ>; Sat, 17 Nov 2001 02:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKQHN6>; Sat, 17 Nov 2001 02:13:58 -0500
Received: from mail.direcpc.com ([198.77.116.30]:46802 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S281708AbRKQHNx>; Sat, 17 Nov 2001 02:13:53 -0500
Subject: [EMU10K1] Bug in EMU10K1
From: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 17 Nov 2001 02:10:50 -0500
Message-Id: <1005981053.1377.0.camel@Eleusis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having difficulty making an E-MU E-Card work with any degree of
success under Linux.  Accoring to the notes in the driver, this card is
listed as supported:

drivers/sound/emu10k1/main.c
 *      0.3 Fixed mixer routing bug, added APS, joystick support.
 *	0.7 Support for the Emu-APS. Bug fixes for voice cache setup, mmaped
sound + poll().
 
The modules load, mixer loads (but only has controls for 'Master'
and 'DSP'), can use audio applications but don't hear sound.  System
crashes (hard-lock, no SysReq, etc.) if audio is stoped and restarted.

I had no trouble making a vanilla Live work with any of these drivers.  

Driver is stock RH kernel from 2.4.9-12 with and without SMP - also
tried CVS
driver from Creative (11/02/2001) with same results.  System is IBM
NetFinity 5600 with 2x
PIII's @ 666 MHz.  Card is an E-MU E-Card without E-Drive.

/sbin/modprobe emu10k1
Nov 17 02:00:31 Eleusis kernel: Creative EMU10K1 PCI Audio Driver,
version 0.7,
18:28:17 Oct 30 2001
Nov 17 02:00:31 Eleusis kernel: emu10k1: EMU10K1 rev 5 model 0x4001
found, IO at
0x2020-0x203f, IRQ 18

/sbin/lspci -v00:0a.0 Multimedia audio controller: Creative Labs SB
Live!
EMU10000 (rev 05)
	Subsystem: Creative Labs E-mu APS
	Flags: bus master, medium devsel, latency 48, IRQ 18
	I/O ports at 2020 [size=32]
	Capabilities: [dc] Power Management version 1

00:0a.1 Input device controller: Creative Labs SB Live! (rev 05)
	Subsystem: Creative Labs: Unknown device 4001
	Flags: bus master, medium devsel, latency 48
	I/O ports at 2040 [size=8]
	Capabilities: [dc] Power Management version 1





