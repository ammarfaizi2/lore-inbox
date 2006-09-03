Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWICWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWICWRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWICWRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:17:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12549 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750831AbWICWRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:17:02 -0400
Date: Mon, 4 Sep 2006 00:17:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: 2.6.18-rc5-mm1: MMU=n compile error
Message-ID: <20060903221700.GH4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm-tracking-shared-dirty-pages.patch breaks CONFIG_MMU=n architectures:

<--  snip  -->

...
  CC      mm/page-writeback.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/page-writeback.c: In function 'test_clear_page_dirty':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/page-writeback.c:867: error: implicit declaration of function 'page_mkclean'
make[2]: *** [mm/page-writeback.o] Error 1

<--  snip  -->

cu
Adrian

BTW: @Andrew:
     The Cc: line in mm-tracking-shared-dirty-pages.patch is busted.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-- 
VGER BF report: H 0.00135769
