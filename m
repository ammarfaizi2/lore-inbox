Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbTCGKkp>; Fri, 7 Mar 2003 05:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbTCGKkp>; Fri, 7 Mar 2003 05:40:45 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:18152 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261482AbTCGKko>;
	Fri, 7 Mar 2003 05:40:44 -0500
Date: Fri, 7 Mar 2003 11:50:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update PCI quirks
In-Reply-To: <200303070214.h272EH121792@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0303071150040.13981-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1068.10.31, 2003/03/06 17:42:55-08:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] update PCI quirks
> 	
> 	ALi Magik requires workarounds for TV chips
> 	IDE controllers require proper handling in legacy mode
> 	PXB must be disabled on C0 450NX or the IDE will corrupt memory
> 	VIA northbridge devices require the interrupt line is written
> 	NEC_CBUS_2/3 require ISA DMA workarounds
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1068.10.30 -> 1.1068.10.31
> #	drivers/pci/quirks.c	1.23    -> 1.24   
> #
> 
>  quirks.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 110 insertions(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c	Thu Mar  6 18:14:19 2003
> +++ b/drivers/pci/quirks.c	Thu Mar  6 18:14:19 2003

[...]

> + * Q: should we load the 0x1f0,0x3f4 into the registers or zap them as
> + * we do now ? We don't want is pci_enable_device to come along
                  ^^^^^^^^^^^^^^^^
		  What we don't want is?

> + * and assign new resources. Both approaches work for that.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

