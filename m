Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbTAPBvw>; Wed, 15 Jan 2003 20:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTAPBvw>; Wed, 15 Jan 2003 20:51:52 -0500
Received: from smtp.mmedia.is ([217.151.160.9]:8640 "EHLO smtp.mmedia.is")
	by vger.kernel.org with ESMTP id <S267110AbTAPBvu>;
	Wed, 15 Jan 2003 20:51:50 -0500
Date: Tue, 14 Jan 2003 18:21:59 +0000
From: Freyr Gunnar =?ISO-8859-1?Q?=D3lafsson?= <gnarlin@utopia.is>
To: linux-kernel@vger.kernel.org
Subject: amilo-a laptop lockup netcard problem
Message-Id: <20030114182159.676ce167.gnarlin@utopia.is>
Organization: Icer Comunication inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good sirs and ladies of the linux kernel development mailing list.

I am in desperate need of your help. I am no expert, but you *are*.
Problem is as following:

	Problem
		I have a fujitsu siemens amilo a laptop.
		My father gave it to me after having saved for god knows how long.
		I can NOT give it back and tell him that it has a problem with the linux kernel
		(or that the hardware is faulty). So if this can be solved (as I am sure it can) then nobody has
		to know ;)

		amilo a has a RealTek RTL8139 netcard build in to the motherboard.
		Almost every single linux distro out there crashes when I boot it from the install cds (FreeBSD however
		does not seem to have any such problems... hint... hint :)

		After trying almost any distro on the planet I finally came back to the old faithful.. slackware.
		For some reason the bare.i kernel boots just fine. However as soon as I tried to autoprobe the netcard is 
		gave a kernel panic as well as some memory adresses (which I will give at the bottom of this letter).
		Aparently it crashed when trying to modprobe for the de4x5.o netcard module. Thankfully slackware offers a way
		to skip a probe for a particular module (network; S de4x5.o) and then the autoprobe program found a working driver
		(apparently since slackware is running now with network support working).

		I tought that I might compile a new kernel for my laptop since there was very little hardware support in bare.i
		kernel that came with slackware (sound support for the sound chip, scsi etc.). I have tried so many different kernel
		combonations that my hands are bleeding and the arrow buttons are smoking ;(

		The only thing that I notice different was when I disabled isa-plug-and-play support for my new kernel it managed to
		boot just a little bit further I think, although the kernel still paniced and gave those same memory adressess.

	Booting kernel message

		Here is some the the kernel messages. I will only write the last few lines before the kernel crashes (since I assume
		only those are nessicery ..... and my fingers are still bleeding ;þ

		-------------------------------------
		Starting PCMCIA services:
		cardmgr[49]: watching 2 sockets
		cardmgr[49]: Card services release does not match
		cs: IO port probe 0x0c00-0x0cff: clean
		cs: IO port probe 0x0800-0x08ff: clean
		cs: IO port probe 0x0100-04ff:<0>CPU 0: Machine Check Exception: 0000000000000
		007
		Bank 3: b40000000000083b at 00000001fc0003b0
		Kernel panic: Unable to continue
		--------------------------------------

		The bare.i kernel from slackware that boots so well is a 2.4.18
		The kernel I tried to compile so often was a vanilla 2.4.20 kernel.
		The install cd's that I tried where gentoo live-cd 1.4rc2, red-hat 8 standard, rootlinux. They all exploded 
		(paniced) on ignition :(

		here is stuff from lspci list (I really don't know what information would be helpful for you poeple so if there is
		anything that I should do or if there is a procedure for info I should include please tell me)

	lspci
		--------------------------------------
		00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
		00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 700f (rev 01)
		00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03)
		00:03.0 Modem: Acer Laboratories Inc. [ALi] M5457 AC-Link Modem Interface Controller
		00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
		00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
		00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
		00:08.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 02)
		00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
		00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
		00:0b.0 CardBus bridge: ENE Technology Inc: Unknown device 1420 (rev 01)
		00:0b.1 CardBus bridge: ENE Technology Inc: Unknown device 1420 (rev 01)
		00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03)
		01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4336
		--------------------------------------

	Please return true;


Freyr Gunnar Ólafsson
gnarlin at utopia dot is (sorry bout that)
