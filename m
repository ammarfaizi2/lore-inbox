Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSLAPrU>; Sun, 1 Dec 2002 10:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSLAPrU>; Sun, 1 Dec 2002 10:47:20 -0500
Received: from p50817B16.dip.t-dialin.net ([80.129.123.22]:24549 "HELO
	linux.tuxnetwork.de") by vger.kernel.org with SMTP
	id <S261874AbSLAPrT>; Sun, 1 Dec 2002 10:47:19 -0500
Message-ID: <3DEA3D39.7050806@gentoo.org>
Date: Sun, 01 Dec 2002 17:47:53 +0100
From: Bjoern Brauel <bjb@gentoo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel build of 2.5.50 fails on Alpha
References: <000701c2994d$5ccee670$3640a8c0@boemboem>
In-Reply-To: <000701c2994d$5ccee670$3640a8c0@boemboem>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:

>kernel build of 2.5.50 fails on Alpha:
>
>
>
>gcc -Wp,-MD,init/.do_mounts.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-protot
>ypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointe
>r -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6 -nostdinc -iwithprefix
>include    -DKBUILD_BASENAME=do_mounts -DKBUILD_MODNAME=do_mounts   -c -o
>init/do_mounts.o init/do_mounts.c
>In file included from include/linux/raid/md.h:27,
>                 from init/do_mounts.c:25:
>include/linux/module.h:135: field `arch' has incomplete type
>make[1]: *** [init/do_mounts.o] Error 1
>make: *** [init] Error 2
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
2.5 on alpha appears to be quite incomplete right now. The module 
load/unload code appears to be completely out of sync with the other 
archs though some parts that suggest implementation is currently 
underway can be found . Still include/asm-alpha/module.h is empty thus 
struct mod_arch_specific does not exist and you encounter the above 
mentioned error.
Ive been working on implementing some missing bits but what Id like to 
know is who is "officially" doing development for alpha on 2.5.

