Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291795AbSBNRV3>; Thu, 14 Feb 2002 12:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291794AbSBNRVT>; Thu, 14 Feb 2002 12:21:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4869 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291795AbSBNRVG>; Thu, 14 Feb 2002 12:21:06 -0500
Subject: Re: cleanup for i810 chipset for 2.5.5-pre1.
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Thu, 14 Feb 2002 17:34:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202141813140.30210-100000@Expansa.sns.it> from "Luigi Genoni" at Feb 14, 2002 06:15:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bPmc-0000bD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This allows i810_audio and i810 drm modules to compile cleanly and to
> be loaded and used on 2.5.5-pre1 without unresolved symbols.

Not another copy. Please see the kernel list archive. This change is
not the right solution. The driver must be adapted to the new PCI DMA API
(see Documentation/DMA-Mapping.txt)

>         dmap->raw_buf = start_addr;
> -       dmap->raw_buf_phys = virt_to_bus(start_addr);
> +       dmap->raw_buf_phys = virt_to_phys(start_addr);

isa_virt_to_bus should be safe here..

