Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRAWUHO>; Tue, 23 Jan 2001 15:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130362AbRAWUHE>; Tue, 23 Jan 2001 15:07:04 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:2944
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S131447AbRAWUGx>; Tue, 23 Jan 2001 15:06:53 -0500
Date: Tue, 23 Jan 2001 12:05:00 -0500
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200101231705.f0NH50M01015@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: jhartmann@valinux.com, Michael Guntsche <m.guntsche@epitel.at>
Cc: linux-kernel@vger.kernel.org,
        "Dri-devel@lists.sourceforge.net" <Dri-devel@lists.sourceforge.net>
Subject: Re: AGPGART problems with VIA KX133 chipsets under 2.2.18/2.4.0
In-Reply-To: <3A6DB677.2060109@valinux.com>
In-Reply-To: <NDBBJOKGIPCDBEEFHNFPGECPCAAA.m.guntsche@epitel.at> <3A6DB677.2060109@valinux.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

>Michael Guntsche wrote:
>
>> While playing around with the agpgart module I noticed the following strange
>> behaviour.
>> 
>> The hardware in question is an Asus K7V with the KX133 chipset and has been
>> tested on both 2.4.0 and 2.2.18 kernels.
>
>Can you try this patch and tell me if it fixes the problem (against 2.4.0)?
>
>--- agpgart_be.c~	Fri Dec 29 15:07:21 2000
>+++ agpgart_be.c	Tue Jan 23 09:45:49 2001
>@@ -1384,7 +1384,9 @@
> 	aper_size_info_8 *previous_size;
> 
> 	previous_size = A_SIZE_8(agp_bridge.previous_size);
>+#if 0
> 	pci_write_config_dword(agp_bridge.dev, VIA_ATTBASE, 0);
>+#endif
> 	pci_write_config_byte(agp_bridge.dev, VIA_APSIZE,
> 			      previous_size->size_value);
> }

I have the same hardware as Michael Guntsche, and this patch fixes the
problem for me.

Cheers, Wayne
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
