Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162058AbWKOXQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162058AbWKOXQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162059AbWKOXQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:16:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23560 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1162058AbWKOXQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:16:28 -0500
Date: Thu, 16 Nov 2006 00:16:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Message-ID: <20061115231626.GC31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paravirt breaks CONFIG_X86_PAE=y compilation:

<--  snip  -->

...
  CC      init/main.o
In file included from include2/asm/pgtable.h:245,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:11,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:113,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' was here
include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' was here
make[2]: *** [init/main.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

