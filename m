Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUHFUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUHFUGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUHFUEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:04:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59382 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268271AbUHFT6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:58:14 -0400
Date: Fri, 6 Aug 2004 21:58:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, hch@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.6.8-rc3-mm1: sk98lin/skge.c compile error with PROC_FS=n
Message-ID: <20040806195800.GB2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>...
> All 450 patches
>...
> bk-netdev.patch
>...

This breaks compilation with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC [M]  drivers/net/sk98lin/skge.o
drivers/net/sk98lin/skge.c: In function `skge_remove_one':
drivers/net/sk98lin/skge.c:5116: warning: implicit declaration of 
function `remove_proc_entry'
drivers/net/sk98lin/skge.c:5116: `pSkRootDir' undeclared (first use in 
this function)
drivers/net/sk98lin/skge.c:5116: (Each undeclared identifier is reported 
only once
drivers/net/sk98lin/skge.c:5116: for each function it appears in.)
drivers/net/sk98lin/skge.c: In function `skge_init':
drivers/net/sk98lin/skge.c:5188: `SK_Root_Dir_entry' undeclared (first 
use in this function)
make[3]: *** [drivers/net/sk98lin/skge.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

