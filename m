Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQLQRNb>; Sun, 17 Dec 2000 12:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQLQRNV>; Sun, 17 Dec 2000 12:13:21 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:59396 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129449AbQLQRNJ>;
	Sun, 17 Dec 2000 12:13:09 -0500
Message-Id: <200012171632.eBHGWGB01116@sleipnir.valparaiso.cl>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Sun, 17 Dec 2000 21:32:24 +1100." <1875.977049144@ocs3.ocs-net> 
Date: Sun, 17 Dec 2000 13:32:15 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:

[...]

> Messing about with conditional compilation because the link order is
> incorrect is the wrong fix.  The mtd/Makefile must link the objects in
> the correct order.
> 
> cfi_probe.o needs to come after cfi_cmdset_000?.o.
> doc_probe.o needs to come after doc200?.o.
> nora.o, octagon-5066.o, physmap.o, rpxlite.o, vmax301.o, pnc2000.o need
> to come after cfi_probe.o.
> octagon-5066.o, vmax301.o need to come after jedec.o.
> octagon-5066.o, vmax301.o need to come after map_ram.o.
> octagon-5066.o, vmax301.o need to come after map_rom.o.

Would tsort(1) perhaps help?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
