Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTIEGbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTIEGbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 02:31:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44997 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261702AbTIEGbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 02:31:44 -0400
Date: Fri, 5 Sep 2003 08:31:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre3: bttv-cards.c doesn't compile with CONFIG_FW_LOADER
Message-ID: <20030905063139.GL1374@fs.tum.de>
References: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

I got the following compile error in 2.4.23-pre3 with CONFIG_FW_LOADER 
enabled:

<--  snip  -->

...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre3-full/inclu
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=bttv_cards  -c -o bttv-cards.o bttv-cards.c
bttv-cards.c: In function `pvr_boot':
bttv-cards.c:2552: structure has no member named `dev'
bttv-cards.c:2555: warning: implicit declaration of function `request_firmware'
bttv-cards.c:2559: `rc' undeclared (first use in this function)
bttv-cards.c:2559: (Each undeclared identifier is reported only once
bttv-cards.c:2559: for each function it appears in.)
bttv-cards.c:2561: dereferencing pointer to incomplete type
bttv-cards.c:2561: dereferencing pointer to incomplete type
bttv-cards.c:2562: warning: implicit declaration of function `release_firmware'
make[4]: *** [bttv-cards.o] Error 1
make[4]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.23-pre3-full/drivers/media/video'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

