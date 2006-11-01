Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423927AbWKACxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423927AbWKACxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423924AbWKACxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:53:06 -0500
Received: from prettybrd.com ([69.60.120.20]:22277 "EHLO prettybrd.com")
	by vger.kernel.org with ESMTP id S1423927AbWKACxE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:53:04 -0500
Message-ID: <20061031215258.x5rfk2ucmcc88sk4@mail.prettybrd.com>
Date: Tue, 31 Oct 2006 21:52:58 -0500
From: lkml@prettybrd.com
To: linux-kernel@vger.kernel.org
Subject: [2.6.18 AMD64] atiixp: codec read timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkml@prettybrd.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to get sound working on a DFI INFINITY RS482 I am getting a  
barrage of these errors. Here is the what I am seeing in dmesg

atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
...
atiixp: codec read timeout (reg 0)
atiixp: codec read timeout (reg 3c)
atiixp: codec read timeout (reg 1c)
AC'97 2 does not respond - RESET
AC'97 2 access is not valid [0xffffffff], removing mixer.
atiixp: no codec available

I get the same error with ACPI disabled (both in BIOS and with the  
'noacpi' kernel option), as well as when I disable SMP. I also tried  
with a 32bit kernel, but run into the same problem.

My .config can be found here:
http://www.prettybrd.com/~leedo/config

The output of lspci is:

00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 10)
00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
00:11.0 IDE interface: ATI Technologies Inc ATI 437A Serial ATA  
Controller (rev 80)
00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA  
Controller (rev 80)
00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host  
Controller (rev 80)
00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host  
Controller (rev 80)
00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host  
Controller (rev 80)
00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 81)
00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI  
IDE Controller ATI (rev 80)
00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge (rev 80)
00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (rev 80)
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400  
AC'97 Audio Controller (rev 80)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8  
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8  
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8  
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8  
[Athlon64/Opteron] Miscellaneous Control
01:05.0 VGA compatible controller: ATI Technologies Inc RS482 [Radeon  
Xpress 200]
02:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host  
Controller (rev 80)
02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169  
Gigabit Ethernet (rev 10)


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

