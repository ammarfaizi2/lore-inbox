Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVEAW3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVEAW3g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVEAW30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:29:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47886 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261186AbVEAW3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:29:19 -0400
Date: Mon, 2 May 2005 00:29:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauriciolin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3-mm2: fs/proc/task_mmu.c warnings
Message-ID: <20050501222916.GB3592@stusta.de>
References: <20050430164303.6538f47c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc-pid-smaps.patch caused the following warnings with 
CONFIG_HIGHPTE=y:

<--  snip  -->

...
  CC      fs/proc/task_mmu.o
fs/proc/task_mmu.c: In function `smaps_pte_range':
fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'
...

<--  snip  -->

Unfortunately, I do not understand how to fix this properly.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


