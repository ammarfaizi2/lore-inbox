Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbQLPXu2>; Sat, 16 Dec 2000 18:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbQLPXuS>; Sat, 16 Dec 2000 18:50:18 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:10564 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130873AbQLPXuC>; Sat, 16 Dec 2000 18:50:02 -0500
Date: Sun, 17 Dec 2000 00:19:20 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: test13-pre2 fails "make xconfig" in isdn/Config.in
In-Reply-To: <3A3B53BE.41C31B99@t-online.de>
Message-ID: <Pine.LNX.4.31.0012170016050.31429-100000@phoenix.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, Gunther Mayer wrote:

This patch does not fix all problems in isdn/eicon.

A bigger patch is on the way.

Thanx,
Armin

> Hi Linus,
> apply this patch if like to fix this obvious error
> with "make xconfig" on plain tree:
> 	./tkparse < ../arch/i386/config.in >> kconfig.tk
> 	drivers/isdn/Config.in: 98: can't handle dep_bool/dep_mbool/dep_tristate condition
> 	make[1]: *** [kconfig.tk] Error 1
> 	make[1]: Leaving directory `/usr/src/linux/scripts'
>
> -
> Gunther
>
>
>
>
> --- linux/drivers/isdn/Config.in-240t13pre2-orig        Sat Dec 16 12:20:59 2000
> +++ linux/drivers/isdn/Config.in        Sat Dec 16 12:21:48 2000
> @@ -95,7 +95,7 @@
>        dep_bool  '    Eicon PCI DIVA Server BRI/PRI/4BRI support' CONFIG_ISDN_DRV_EICON_PCI $CONFIG_PCI
>        bool      '    Eicon S,SX,SCOM,Quadro,S2M support' CONFIG_ISDN_DRV_EICON_ISA
>     fi
> -   dep_tristate '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
> +   bool '  Build Eicon driver type standalone' CONFIG_ISDN_DRV_EICON_DIVAS
>  fi
>
>  # CAPI subsystem
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
