Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271723AbTG2OPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTG2OPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:15:48 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:19620 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S271723AbTG2OP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:15:29 -0400
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>
Cc: <herbert@13thfloor.at>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems related to DMA or DDR memory on Intel 845 chipset?
References: <PMEMILJKPKGMMELCJCIGOELDCDAA.kfrazier@mdc-dayton.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 29 Jul 2003 16:15:14 +0200
In-Reply-To: <PMEMILJKPKGMMELCJCIGOELDCDAA.kfrazier@mdc-dayton.com>
Message-ID: <m3d6ftxvv1.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kathy Frazier" <kfrazier@mdc-dayton.com> writes:

> We are attached to some industrial equipment.  Yes, DMA busmaster.  Yes, the
> device asserts it's interrupt.  At some point things get totally hosed and
> that interrupt never gets through.  We then have to reset the machine . . .

Looks like malfunction of your card or driver. Is it a new design or
is it already working with, say, Windows or something?

> 00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
> (rev 02)
> 00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
> (rev 02)
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
> 00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
> 00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra
> TF
> 02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> Controller (rev 80)
> 02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
> 02:09.0 Communication controller: Altera Corporation PCI Fiber Optic Engrave
> Interface (rev 02)

Does the above list include your card? Which one is it? Could you show
lspci -vv output for that device?

> Jul 22 08:22:29 rti10 aksparlnx: ^I/opt/aksparlnx/drv/2.4.19/aksparlnx.o was
> compiled for kernel version 2.4.19
> Jul 22 08:22:29 rti10 aksparlnx: ^Iwhile this kernel is version 2.4.20-8
> Jul 22 08:22:29 rti10 aksparlnx: Warning: loading
> /opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: non-GPL
> license - Copyright 1999-2002 Aladdin Knowledge Systems.

Is is your driver?

Have you tried running the box (with your card) without any unnecessary
devices (plugged/loaded)?
-- 
Krzysztof Halasa
Network Administrator
