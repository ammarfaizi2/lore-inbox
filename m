Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318421AbSGaRko>; Wed, 31 Jul 2002 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSGaRko>; Wed, 31 Jul 2002 13:40:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3577 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318421AbSGaRkm>; Wed, 31 Jul 2002 13:40:42 -0400
Subject: Re: [BUGS] 2.5.29: scsi/pcmcia|sound/trident|devfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nico Schottelius <nico-mutt@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020731171517.GA818@schottelius.org>
References: <20020731171517.GA818@schottelius.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 Jul 2002 20:00:14 +0100
Message-Id: <1028142014.7886.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 18:15, Nico Schottelius wrote:
> 
> make[3]: Entering directory `/usr/src/linux-2.5.29/drivers/scsi/pcmcia'
>   gcc -Wp,-MD,./.nsp_cs.o.d -D__KERNEL__ -I/usr/src/linux-2.5.29/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
>   -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux-2.5.29/include/linux/modversions.h
>   -DKBUILD_BASENAME=nsp_cs   -c -o nsp_cs.o nsp_cs.c
>   nsp_cs.c: In function `nsp_queuecommand':

The author sent me an updated driver for this. I'm waiting for Linus to
put out .30 so I can resync and send more patches. I'll probably also
drop it into 2.4-ac.

> 
> make[2]: Entering directory `/usr/src/linux-2.5.29/sound/oss'
>   gcc -Wp,-MD,./.trident.o.d -D__KERNEL__ -I/usr/src/linux-2.5.29/include -Wall
>   -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux-2.5.29/include/linux/modversions.h
>    -DKBUILD_BASENAME=trident   -c -o trident.o trident.c
> trident.c:2124: macro `synchronize_irq' used without args
> trident.c:2131: macro `synchronize_irq' used without args

I have this fixed in my tree. I have a seperate problem where the
trident drivers blow up gcc 3.1 but thats reported and a gcc issue.
Again I'll send this for .30 if its not done

> CONFIG_PREEMPT=y

Be careful with this. Its still not safe for several things (kernel FPU
using stuff for example)


