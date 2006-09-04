Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWIDRET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWIDRET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWIDRES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:04:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9229 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964928AbWIDREP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:04:15 -0400
Date: Mon, 4 Sep 2006 19:04:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg Banks <gnb@melbourne.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc5-mm1: ARCH_DISCONTIGMEM_ENABLE=y, SMP=n compile error
Message-ID: <20060904170411.GT4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask-add-highest_possible_node_id.patch causes the following compile 
error with CONFIG_ARCH_DISCONTIGMEM_ENABLE=y, CONFIG_SMP=n
(and CONFIG_SUNRPC=y):

<--  snip  -->

...
  LD      vmlinux
net/built-in.o: In function `svc_create_pooled':
(.text+0x675fc): undefined reference to `highest_possible_node_id'
net/built-in.o: In function `svc_create_pooled':
(.text+0x675fc): relocation truncated to fit: R_M32R_26_PCREL_RELA against undefined symbol `highest_possible_node_id'
make[1]: *** [vmlinux] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

