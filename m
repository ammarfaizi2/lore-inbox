Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269995AbRHETXA>; Sun, 5 Aug 2001 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269996AbRHETWk>; Sun, 5 Aug 2001 15:22:40 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:36788 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S269995AbRHETWd>; Sun, 5 Aug 2001 15:22:33 -0400
Date: Sun, 5 Aug 2001 15:22:40 -0400
Message-Id: <200108051922.f75JMeb11594@moisil.badula.org>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Federico Sevilla III <jijo@leathercollection.ph>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xircom CardBus RBE-100 "No MII transceiver found"
In-Reply-To: <Pine.LNX.4.33.0108040006540.4008-100000@gusi.leathercollection.local>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.6-ac5 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Federico,

On Sat, 4 Aug 2001 00:16:23 +0800 (PHT), Federico Sevilla III <jijo@leathercollection.ph> wrote:

> I'm using 2.4.8-pre3, with pcmcia-cs 3.1.27 (no pcmcia modules from the
> pcmcia package, all from the kernel). I have support for CardBus built in.
> I've tried compiling support for my Xircom CardBus RBE-100 into the kernel
> and as a module. It just won't work. 

I was the last one doing work on the xircom_tulip_cb driver, although none
of the changes that got into 2.4.7 should affect the driver's behavior. I
only removed dead code...

Anyway, can you try a 2.4.6 kernel (which doesn't have my changes), and see
if the card works?

> cs: cb_alloc(bus 5): vendor 0x115d, device 0x0003
> PCI: Failed to allocate resource 0(1000-fff) for 05:00.0

The above sounds like the real trouble. Can you run a 'lspci -vv' and
mail the section corresponding to the 05:00.0 device to the list?

> xircom_tulip_cb.c:v0.91 4/14/99 becker@scyld.com (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
> xircom(05:00.0): ***WARNING***: No MII transceiver found!
> eth0: Xircom Cardbus Adapter (DEC 21143 compatible mode) rev 3 at 0x1000, 00:00:00:00:00:00, IRQ 9.

We really can't talk to the card, which is not very surprising considering
that the PCI resource 0 couldn't be allocated. 

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
