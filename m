Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131586AbRCOIIK>; Thu, 15 Mar 2001 03:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbRCOIIA>; Thu, 15 Mar 2001 03:08:00 -0500
Received: from mail.valinux.com ([198.186.202.175]:20233 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131586AbRCOIHt>;
	Thu, 15 Mar 2001 03:07:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: IDE poweroff -> hangup
X-Newsgroups: linux.kernel
In-Reply-To: <Pine.LNX.4.10.10103142010300.7091-100000@master.linux-ide.org>
From: chip@valinux.com (Chip Salzenberg)
In-Reply-To: <00cb01c0acf8$83125ee0$61acd6d2@ninzazrouter>
Organization: VA Linux Systems
Message-Id: <E14dSmq-00072K-00@traeki.engr.valinux.com>
Date: Thu, 15 Mar 2001 00:07:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick writes:
>On Thu, 15 Mar 2001, CODEZ wrote:
>> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>> I have ASUS 440BX/F mb with intel PIIX4 chipset......
>
>All of the 440*X Chipsets using a PIIX4/PIIX4AB/PIIX4EB are broken beyond
>repair.

Well, that may be so; but I get the same error -- *precisely* the same
error! -- on an SiS motherboard that quite clearly lacks a PIIX4:

  # lspci
  00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 02)
  00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
  00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b1)
  00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
  00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 11)
  00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
  00:0b.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
  01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev a2)

  # lspci -v -s0:0
  00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 02)
        Flags: bus master, medium devsel, latency 32
        Memory at e0000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 2.0

  00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
        Flags: bus master, fast devsel, latency 128, IRQ 14
        I/O ports at e400
        I/O ports at e000
        I/O ports at d800
        I/O ports at d400
        I/O ports at d000

So...  Any ideas?

> I will pop a nasty patch to get you through the almost death, but it
> is nasty and not the preferred unknow solution.

I await your fugly patch with bated breath and baited fishook.
-- 
Chip Salzenberg    a.k.a.    <chip@valinux.com>
