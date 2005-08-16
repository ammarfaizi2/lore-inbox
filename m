Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVHPKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVHPKBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVHPKBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:01:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:47537 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965179AbVHPKBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:01:47 -0400
Date: Tue, 16 Aug 2005 12:01:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git5 : PCI mem resource alloc failure
In-Reply-To: <1123982870.2779.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508161200480.32120@yvahk01.tjqt.qr>
References: <1123982870.2779.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>With 2.6.13-rc6-git5 I started getting the below errors. Despite of the
>errors everything works fine. (only problem is that I have to
>disconnect /reconnect the usb mouse for it to get detected..)
>
>[   47.883970] PCI: Failed to allocate mem resource #10:2000000@e2000000
>for 000 0:02:04.0
>[   47.884002] PCI: Failed to allocate mem resource #10:2000000@e2000000
>for 000 0:02:04.1

cat /proc/iomem before you modprobe the module - is 20000000 already reserved 
by the motherboard?

>[   47.884170] PCI: Setting latency timer of device 0000:00:0a.0 to 64
>[   47.884806] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 19
>[   47.884818] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNK1] -> GSI
>19 (lev el, low) -> IRQ 177
>[   47.885434] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 18
>[   47.885442] ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNK2] -> GSI
>18 (lev el, low) -> IRQ 185
>[   47.886005] agpgart: Detected AGP bridge 0
>[   47.886017] agpgart: Setting up Nforce3 AGP.
>[   47.893822] agpgart: AGP aperture is 128M @ 0xe8000000



Jan Engelhardt
-- 
