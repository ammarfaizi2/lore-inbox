Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSGHLYf>; Mon, 8 Jul 2002 07:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSGHLYe>; Mon, 8 Jul 2002 07:24:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51963 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313773AbSGHLYd>; Mon, 8 Jul 2002 07:24:33 -0400
Date: Mon, 8 Jul 2002 13:27:09 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andre Hedrick <andre@linux-ide.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 patch] document that cmd64x.c supports the CMD649 and
 CMD680chipsets
In-Reply-To: <Pine.LNX.4.10.10207071337360.31523-100000@master.linux-ide.org>
Message-ID: <Pine.NEB.4.44.0207081317290.20908-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2002, Andre Hedrick wrote:

> CMD680 will be extracted out to siiimage.c as it is a differnet driver
> with dual transport modes.  I just need to resort patches first.

I suspect this change won't be included in 2.4.19. Since 2.4.19 is a
stable kernel and the change is pretty easy revertible I hope you don't
disagree on including my small patch.


The typical scenario I've already seen if such a patch was missing is:
- "My disk is very slow/slower than under Windows."
- it turns out the disk doesn't use DMA
- the self-compiled kernel doesn't include the IDE driver for the chipset
  in the computer because:
  - "HPT366 chipset support" doesn't sound like the right option for a
    HPT370
  - CMD649 isn't listed as a supported chipset


Compared to the work needed to write the code to support a chipset these
small documentation updates to Config.in and
$(TOPDIR)/Documentation/Configure.help are really small - but they are
important for users to benefit from the driver.


> Cheers,

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


