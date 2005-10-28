Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVJ1Jza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVJ1Jza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVJ1Jza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:55:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:21895 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751243AbVJ1Jz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:55:29 -0400
Date: Fri, 28 Oct 2005 11:55:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <1cb7.435fd492.4a69a@altium.nl>
Message-ID: <Pine.LNX.4.61.0510281056230.24372@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
 <1cb7.435fd492.4a69a@altium.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Linus Torvalds <torvalds@osdl.org> wrote:
>| can you please test out this patch and report what it says in dmesg?

Here is an exotic one, from VMware (uses PIIX too). Says


PCI quirk: region 1000-103f claimed by PIIX4 ACPI
PCI quirk: region 1040-105f claimed by PIIX4 SMB
...later...
PCI: Cannot allocate resource region 4 of device 0000:00:07.1
...later...
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later


> -more /proc/ioports (I'm using sash for this test ;-))
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-103f : 0000:00:07.3
  1000-103f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    100c-100f : GPE0_BLK
1040-105f : 0000:00:07.3
  1040-104f : motherboard
1060-106f : 0000:00:0f.0
1070-107f : 0000:00:07.1
  1070-1077 : ide0
  1078-107f : ide1
1080-10ff : 0000:00:10.0



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
