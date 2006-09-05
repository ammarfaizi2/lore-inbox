Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWIESR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWIESR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWIESR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:17:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57863 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030205AbWIESRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:17:24 -0400
Date: Tue, 5 Sep 2006 20:17:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gerg@uclinux.org
Cc: linux-kernel@vger.kernel.org
Subject: m68knommu: dma_{alloc,free}_coherent compile error
Message-ID: <20060905181716.GG9173@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error trying to compile 2.6.18-rc5-mm1 
(but it doesn't seem to be specific to -mm) for m68knommu with 
CONFIG_PCI=n (with -Werror-implicit-function-declaration):

<--  snip  -->

...
  CC      drivers/base/dmapool.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c: In function 'pool_alloc_page':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c:170: error: implicit declaration of function 'dma_alloc_coherent'
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c:173: warning: assignment makes pointer from integer without a cast
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c: In function 'pool_free_page':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/base/dmapool.c:208: error: implicit declaration of function 'dma_free_coherent'
make[3]: *** [drivers/base/dmapool.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

