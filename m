Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQLPXqh>; Sat, 16 Dec 2000 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130797AbQLPXq1>; Sat, 16 Dec 2000 18:46:27 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:5971 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129465AbQLPXqK>; Sat, 16 Dec 2000 18:46:10 -0500
Date: Sun, 17 Dec 2000 00:15:22 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: <isdn4linux@listserv.isdn4linux.de>, <linux-kernel@vger.kernel.org>
Subject: Re: doubly defined symbols in drivers/isdn/eicon (240t13p2)
In-Reply-To: <20001216210652.A609@jaquet.dk>
Message-ID: <Pine.LNX.4.31.0012170013150.31429-100000@phoenix.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The last Makefile changes broke some parts in the
isdn tree.
Patch is on the way.

Armin


On Sat, 16 Dec 2000, Rasmus Andersen wrote:

> Hi.
>
> When I try to compile kernel 240test13pre2 I get the following:
>
>
> rm -f eicon_drv.o
> ld -m elf_i386  -r -o eicon_drv.o eicon.o divas.o
> divas.o: In function `eicon_init':
> divas.o(.text+0x61d0): multiple definition of `eicon_init'
> eicon.o(.text+0x197c): first defined here
> ld: Warning: size of symbol `eicon_init' changed from 370 to 83 in divas.o
> divas.o: In function `file_check':
> divas.o(.text+0x61bc): multiple definition of `file_check'
> eicon.o(.text+0xb394): first defined here
> make[4]: *** [eicon_drv.o] Error 1
> make[4]: Leaving directory `/home/rasmus/kernel/linux/drivers/isdn/eicon'
> make[3]: *** [first_rule] Error 2
> make[3]: Leaving directory `/home/rasmus/kernel/linux/drivers/isdn/eicon'
> make[2]: *** [_subdir_eicon] Error 2
> make[2]: Leaving directory `/home/rasmus/kernel/linux/drivers/isdn'
> make[1]: *** [_subdir_isdn] Error 2
> make[1]: Leaving directory `/home/rasmus/kernel/linux/drivers'
> make: *** [_dir_drivers] Error 2
>
>
> The part of my .config I guess is interesting:
>
> #
> # Active ISDN cards
> #
> CONFIG_ISDN_DRV_ICN=y
> CONFIG_ISDN_DRV_PCBIT=y
> CONFIG_ISDN_DRV_SC=y
> CONFIG_ISDN_DRV_ACT2000=y
> CONFIG_ISDN_DRV_EICON=y
> CONFIG_ISDN_DRV_EICON_OLD=y
> # CONFIG_ISDN_DRV_EICON_PCI is not set
> CONFIG_ISDN_DRV_EICON_ISA=y
> CONFIG_ISDN_DRV_EICON_DIVAS=y
> CONFIG_ISDN_CAPI=y
> CONFIG_ISDN_CAPI_MIDDLEWARE=y
> CONFIG_ISDN_CAPI_CAPIFS=y
> CONFIG_ISDN_CAPI_CAPI20=y
> CONFIG_ISDN_CAPI_CAPIDRV=y
>
>
> --
> Regards,
>         Rasmus(rasmus@jaquet.dk)
>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
