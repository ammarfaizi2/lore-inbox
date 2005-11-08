Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965679AbVKHCoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965679AbVKHCoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965684AbVKHCoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:44:46 -0500
Received: from [81.2.110.250] ([81.2.110.250]:7108 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965679AbVKHCop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:44:45 -0500
Subject: Re: 2.6.14-mm1 libata pata_via
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 03:15:26 +0000
Message-Id: <1131419726.19575.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-07 at 17:32 +0000, Chris Boot wrote:
> Hi all,
> 
> Since I've only got a DVD drive on good ol' PATA, I thought I'd try  
> Alan's latest VIA PATA driver for libata, to see where I got. Well,  
> the machine simply doesn't boot, preferring to get stuck after  
> detecting the drive. I've tried with and without  
> libata.atapi_enabled=1 and get the same result in both cases. Here's  
> my log with some SysRq output that might be useful:

Thanks for giving it a try. Can you also give me an lspci -v for
reference

> [4294672.373000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] - 
>  > GSI 20 (level, low) -> IRQ 177
> [4294672.411000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1

Thats suspicious in itself. I take it the VIA drivers/ide driver works
fine and reports IRQ 1 however ?

> [4294672.446000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma  
> 0xD000 irq 14

