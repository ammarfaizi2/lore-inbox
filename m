Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWIENZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWIENZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWIENZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:25:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10501 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964859AbWIENZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:25:38 -0400
Date: Tue, 5 Sep 2006 15:25:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: 2.6.18-rc5-mm1: {dis,en}able_irq_lockdep_irqrestore compile error
Message-ID: <20060905132530.GD9173@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis.patch causes 
the following compile error on frv:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `ei_start_xmit':
8390.c:(.text+0x241c8): undefined reference to `disable_irq_nosync_lockdep_irqsave'
8390.c:(.text+0x242a0): undefined reference to `enable_irq_lockdep_irqrestore'
8390.c:(.text+0x2440c): undefined reference to `enable_irq_lockdep_irqrestore'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

