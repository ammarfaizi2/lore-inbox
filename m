Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTIVTLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTIVTK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:10:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32489 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262712AbTIVTK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:10:57 -0400
Date: Mon, 22 Sep 2003 21:10:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm4: wanxl doesn't compile with gcc 2.95
Message-ID: <20030922191049.GC6325@fs.tum.de>
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922013548.6e5a5dcf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error with gcc 2.95:

<--  snip  -->

...
  CC      drivers/net/wan/wanxl.o
drivers/net/wan/wanxl.c: In function `pci_map_single_debug':
drivers/net/wan/wanxl.c:128: warning: unsigned int format, different type arg (arg 3)
drivers/net/wan/wanxl.c: In function `wanxl_tx_intr':
drivers/net/wan/wanxl.c:185: parse error before `struct'
drivers/net/wan/wanxl.c:200: `skb' undeclared (first use in this function)
drivers/net/wan/wanxl.c:200: (Each undeclared identifier is reported only once
drivers/net/wan/wanxl.c:200: for each function it appears in.)
drivers/net/wan/wanxl.c: In function `wanxl_xmit':
drivers/net/wan/wanxl.c:298: parse error before `*'
drivers/net/wan/wanxl.c:299: `desc' undeclared (first use in this function)
drivers/net/wan/wanxl.c: In function `wanxl_pci_init_one':
drivers/net/wan/wanxl.c:631: warning: unsigned int format, different type arg (arg 3)
drivers/net/wan/wanxl.c: At top level:
drivers/net/wan/wanxl.c:34: warning: `version' defined but not used
make[3]: *** [drivers/net/wan/wanxl.o] Error 1

<--  snip  -->

For gcc 2.95, all variable declarations must be at the beginning.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

