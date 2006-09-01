Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWIAQAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWIAQAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWIAQA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:00:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3846 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932152AbWIAQA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:00:29 -0400
Date: Fri, 1 Sep 2006 18:00:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
Message-ID: <20060901160023.GB18276@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm3:
>...
> +amso1100-build-fix.patch
> 
>  Fix git-infiniband.patch
>...

This causes the following compile error on i386:

<--  snip  -->

...
  CC      drivers/infiniband/hw/amso1100/c2.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.c: In function ‘c2_tx_ring_alloc’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.c:133: error: implicit declaration of function ‘__raw_writeq’
make[4]: *** [drivers/infiniband/hw/amso1100/c2.o] Error 1

<--  snip  -->

There seems to be some confusion regarding whether __raw_writeq() is 
considered a platform independent API.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

