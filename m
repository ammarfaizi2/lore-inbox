Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132892AbRDJBzv>; Mon, 9 Apr 2001 21:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRDJBzl>; Mon, 9 Apr 2001 21:55:41 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:50699 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S132892AbRDJBz0>; Mon, 9 Apr 2001 21:55:26 -0400
Date: Tue, 10 Apr 2001 09:55:51 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Nick Urbanik <nicku@vtc.edu.hk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre1 Unresolved symbols "strstr"
In-Reply-To: <3AD235D7.E590147@vtc.edu.hk>
Message-ID: <Pine.LNX.4.33.0104100953470.14088-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


got this path from Niels ...

Works for me now.

___________________________________________________________________________

> From: Niels Kristian Bech Jensen <nkbj@image.dk>

Try this patch:

diff -u --recursive --new-file
v2.4.4-pre1/linux/arch/i386/kernel/i386_ksyms.c
linux/arch/i386/kernel/i386_ksyms.c
--- v2.4.4-pre1/linux/arch/i386/kernel/i386_ksyms.c     Sun Apr  8
17:57:45 2001+++ linux/arch/i386/kernel/i386_ksyms.c Mon Apr  9 08:00:13
2001
@@ -97,6 +97,7 @@
 EXPORT_SYMBOL_NOVERS(__put_user_2);
 EXPORT_SYMBOL_NOVERS(__put_user_4);

+EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(simple_strtol);

--
___________________________________________________________________________


Thanks,
Jeff
[ jchua@fedex.com ]

On Tue, 10 Apr 2001, Nick Urbanik wrote:

> Jeff Chua wrote:
>
> > depmod version 2.4.5
> >
> > Compiled 2.4.4-pre1 but running "depmod" generates a lot of these ...
> >
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.4-pre1/kernel/drivers/char/ltmodem.o
> > depmod:         strstr
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.4-pre1/kernel/drivers/char/serial.o
> > depmod:         strstr
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
> > depmod:         strstr
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-mod.o
> > depmod:         strstr
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-probe-mod.o
> > depmod:         strstr
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.4-pre1/pcmcia/xirc2ps_cs.o
> > depmod:         strstr
>
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-tape.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/isdn/avmb1/capidrv.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/isdn/icn/icn.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/de4x5.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/depca.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/ewrk3.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/net/hamradio/baycom_epp.o
> depmod:         strstr
> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre1/kernel/drivers/parport/parport.o
> depmod:         strstr
>
> This is on a Cyrix P-166.  Same with depmod 2.4.2 or 2.3.21
>
> --
> Nick Urbanik, Dept. of Computing and Mathematics
> Hong Kong Institute of Vocational Education (Tsing Yi)
> email: nicku@vtc.edu.hk
> Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
> pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

