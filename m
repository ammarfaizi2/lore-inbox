Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXABt>; Sat, 23 Dec 2000 19:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbQLXABa>; Sat, 23 Dec 2000 19:01:30 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:51950 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129458AbQLXAB0>;
	Sat, 23 Dec 2000 19:01:26 -0500
Date: Sun, 24 Dec 2000 00:10:11 +0100 (CET)
From: kees <kees@schoen.nl>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.19pre3
In-Reply-To: <20001223144411.A835@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0012240009560.1877-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

That did it, thanks
Kees

On Sat, 23 Dec 2000, J . A . Magallon wrote:

> 
> On 2000.12.23 kees wrote:
> > Hi,
> > 
> > Trying to build 2.2.18+pe-patch-2.2.19-3 gives:
> > 
> >  
> > /usr/bin/cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -O2
> > -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce
> > -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o
> > ne2k-pci.o ne2k-pci.c
> > ne2k-pci.c: In function `ne2k_pci_probe':
> > ne2k-pci.c:246: `version' undeclared (first use in this function)
> > ne2k-pci.c:246: (Each undeclared identifier is reported only once
> 
> Sorry, I checked the driver as module but not built into the kernel.
> Try this patch:
> 
> --- linux-2.2.19-pre3/drivers/net/ne2k-pci.c.org        Sat Dec 23 14:40:28 2000
> +++ linux-2.2.19-pre3/drivers/net/ne2k-pci.c    Sat Dec 23 14:41:09 2000
> @@ -243,7 +243,7 @@
>                 {
>                         static unsigned version_printed = 0;
>                         if (version_printed++ == 0)
> -                               printk(KERN_INFO "%s", version);
> +                               printk(KERN_INFO "%s %s", version1,version2);
>                 }
>  #endif
> 
> 
> -- 
> J.A. Magallon                                         $> cd pub
> mailto:jamagallon@able.es                             $> more beer
> 
> Linux werewolf 2.2.19-pre3 #1 SMP Fri Dec 22 02:38:17 CET 2000 i686
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
