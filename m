Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSE2KiM>; Wed, 29 May 2002 06:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSE2KiL>; Wed, 29 May 2002 06:38:11 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:37022 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S314769AbSE2KiK>;
	Wed, 29 May 2002 06:38:10 -0400
Message-ID: <015d01c206fc$dbc018c0$f6de11cc@black>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre9 compile error
Date: Wed, 29 May 2002 06:37:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame
-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -I /usr/local/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/inclu
de -DKBUILD_BASENAME=sdla_fr  -c -o sdla_fr.o sdla_fr.c
sdla_fr.c: In function `process_route':
sdla_fr.c:2819: warning: unknown conversion type character `U' in format
sdla_fr.c:2819: warning: too many arguments for format
sdla_fr.c: In function `process_ARP':
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
make[3]: *** [sdla_fr.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/net/wan'
make[2]: *** [_modsubdir_wan] Error 2

Not sure where the typos came from but here they are:

                        printk(KERN_INFO "%s: Route Added Successfully: %u.%u.%u.%U\n",
Should be          printk(KERN_INFO "%s: Route Added Successfully: %u.%u.%u.%U\n",

                        printk(KERN_INFO "%s: mask %u.%u.%u.%u\n",
                                card->devname, NIPQUAD(in_dev->ida_list->ifa_mask));
                                printk(KERN_INFO "%s: local %u.%u.%u.%u\n",
                                card->devname,NIPQUAD(in_dev->ida_list->ifa_local));

Should be ifa_list -- not ida_list

Michael D. Black mblack@csihq.com
http://www.csihq.com/
http://www.csihq.com/~mike
321-676-2923, x203
Melbourne FL

