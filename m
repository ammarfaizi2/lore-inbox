Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264114AbUEDUqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUEDUqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUEDUqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:46:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56010 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264114AbUEDUqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:46:42 -0400
Date: Tue, 4 May 2004 22:46:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Message-ID: <20040504204633.GB8643@fs.tum.de>
References: <20040503230911.GE7068@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503230911.GE7068@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 08:09:12PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.27-pre1 to v2.4.27-pre2
> ============================================
>...
> Jeff Garzik:
>   o [TG3]: Dump NIC-specific statistics via ethtool
>...

This causes the following compile error:

<--  snip  -->

...
gcc-2.95 -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.27-pre2-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -iwithprefix include -DKBUILD_BASENAME=tg3  -c -o tg3.o tg3.c
tg3.c: In function `tg3_get_strings':
tg3.c:6267: warning: implicit declaration of function `WARN_ON'
...
        -o vmlinux
drivers/net/net.o(.text+0x60293): In function `tg3_get_strings':
: undefined reference to `WARN_ON'
make: *** [vmlinux] Error 1

<--  snip  -->

There's no WARN_ON in 2.4.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

