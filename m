Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVDKVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVDKVFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVDKVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:05:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261938AbVDKVFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:05:12 -0400
Date: Mon, 11 Apr 2005 23:05:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: 2.6.12-rc2-mm3: CONFIG_MODULES=n MTD compile error
Message-ID: <20050411210507.GC5863@stusta.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 01:25:32AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc2-mm2:
>...
> +remove-inter-module-mtd.patch
> 
>  Remove intermodule_foo() usage from mtd.
>...

This breaks the compilation with CONFIG_MODULES=n:

<--  snip  -->

...
  CC      drivers/mtd/devices/docprobe.o
drivers/mtd/devices/docprobe.c: In function `DoC_Probe':
drivers/mtd/devices/docprobe.c:311: warning: implicit declaration of 
function `__symbol_get'
drivers/mtd/devices/docprobe.c:311: warning: assignment makes pointer 
from integer without a cast
drivers/mtd/devices/docprobe.c:315: warning: implicit declaration of function `__symbol_put'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x60f20): In function `DoC_Probe':
: undefined reference to `__symbol_get'
drivers/built-in.o(.init.text+0x60f3b): In function `DoC_Probe':
: undefined reference to `__symbol_put'
drivers/built-in.o(.init.text+0x610a4): In function `DoC_Probe':
: undefined reference to `__symbol_get'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

