Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSK0MLu>; Wed, 27 Nov 2002 07:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSK0MLu>; Wed, 27 Nov 2002 07:11:50 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:55097
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262395AbSK0MLr>; Wed, 27 Nov 2002 07:11:47 -0500
Date: Wed, 27 Nov 2002 07:18:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andika Triwidada <andika@research.indocisc.com>,
       Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "" <linux-net@vger.kernel.org>
Subject: Re: [PATCH] drivers/net/Makefile
In-Reply-To: <20021126212532.GC21307@fs.tum.de>
Message-ID: <Pine.LNX.4.50.0211270716580.1462-100000@montezuma.mastecende.com>
References: <20021103053017.GB29448@research.indocisc.com>
 <20021126212532.GC21307@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Adrian Bunk wrote:

> It has definitely nothing to do with CONFIG_PCMCIA_PCNET.
>
> The following (untested) patch should be correct:
>
> --- linux-2.5.49/drivers/net/Makefile.old	2002-11-26 22:20:27.000000000 +0100
> +++ linux-2.5.49/drivers/net/Makefile	2002-11-26 22:21:34.000000000 +0100
> @@ -79,6 +79,7 @@
>  obj-$(CONFIG_MAC8390) += mac8390.o 8390.o
>  obj-$(CONFIG_APNE) += apne.o 8390.o
>  obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
> +obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
>  obj-$(CONFIG_SHAPER) += shaper.o
>  obj-$(CONFIG_SK_G16) += sk_g16.o
>  obj-$(CONFIG_HP100) += hp100.o

That looks correct, i probably broke that when i added stuff from mii.c
without modifying the Makefile

Thanks,
	Zwane
-- 
function.linuxpower.ca
