Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277531AbRJLHod>; Fri, 12 Oct 2001 03:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277565AbRJLHoW>; Fri, 12 Oct 2001 03:44:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34059 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277531AbRJLHoK>; Fri, 12 Oct 2001 03:44:10 -0400
Subject: Re: 2.4.13-pre1: sonypi.c compile error
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Fri, 12 Oct 2001 08:50:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (list linux-kernel)
In-Reply-To: <3BC62542.CDEAAE@eyal.emu.id.au> from "Eyal Lebedinsky" at Oct 12, 2001 09:03:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rx56-0006KD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now this is what we have here, I can not figure the intentions of the
> author:
> 
> static int __init sonypi_init_module(void) {
>         if (is_sony_vaio_laptop)
>                 return pci_module_init(&sonypi_driver);
>         else
>                 return -ENODEV;
> }

is_sony_vaio_laptop is defined by the DMI layer if the machine is a Sony
vaio. It basically says "don't load this on a non vaio"
