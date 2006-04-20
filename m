Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWDTX1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWDTX1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWDTX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:27:12 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:41178 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S932121AbWDTX1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:27:11 -0400
Date: Thu, 20 Apr 2006 19:27:04 -0400
From: larrystotler@netscape.net
Message-Id: <8C832E9113701BB-26B4-B4FC@mblkn-m06.sysops.aol.com>
X-MB-Message-Source: WebUI
X-MB-Message-Type: User
X-Mailer: Netscape WebMail 15106
Subject: Cardbus problem on Thinkpad 600
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-AOL-IP: 64.12.170.70
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wasn't sure where to send this to.

I am having a problems with the cardbus on my Thinkpad 600/2645.  It 
has a P-II Mobile 300Mhz.

It uses the Texas Instruments PCI-1250 Cardbus controller.  I have 
tried the following kernel versions:

v2.6.13-15-default - openSuSE v10.0 stock kernel
v2.6.13-15.8-default - openSuSE v10.0 updated kernel(caused a dma bug 
that resorted in DMA being disabled on the HD)
v2.6.16.9 - current release kernel built and installed from the 
kernel.org site(no DMA problems noticed)

With v2.6.16.9, I get the following messages:

ACPI: PCI interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 9 (level, 
low) -> IRQ 9
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0092]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.0, mfunc 0xfba97543, devctl 0x62
Yenta TI: socket 0000:00:02.0 probing PCI interrupt failed, trying to 
fix
Yenta TI: socket 0000:00:02.0 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, Carbus support disabled for this socket.
Yenta: check your BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0498, PCI irq 0
Socket status: 30000020
ACPI: PCI Interrupt 0000:00:02.1 [1014:0092]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:02.1, mfunc 0xfba97543, devctl 0x62
Yenta TI: socket 0000:00:02.1 probing PCI interrupt failed, trying to 
fix
cs: pcmcia_socket0: cardbus cards are not supported.
Yenta TI: socket 0000:00:02.1 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, CardBus support is disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0498, PCI irq 0
Socket status: 30000006

I added the following kernel arguements:

lacpi pci=routeirq

This should not be a hardware problem because the cardbus controller 
works fine in 98SE as well as in DSL v2.3, which has the v2.4.26 
kernel.  I did some research, and it looked like this had been fixed in 
the 2.6.15.x series, but I guess not.

I am also having problems with my networking under v2.6.x.  I have a 
prism2_usb device, and when I use this server:

miranda.ctd.anl.gov:7123

it tells me that I have a possible duplex mismatch.  I tried setting it 
manually, but it did not help.  It can send fine, but it will not 
receive properly.  Any help, or anyone that you know that can help, 
would be greatly appriciated.  Thanx.
___________________________________________________
Try the New Netscape Mail Today!
Virtually Spam-Free | More Storage | Import Your Contact List
http://mail.netscape.com

