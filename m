Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWATV0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWATV0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWATV0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:26:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62737 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751065AbWATV0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:26:36 -0500
Date: Fri, 20 Jan 2006 22:26:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, spyro@f2s.com
Subject: 2.6.16-rc1-mm2: arch/arm26/kernel/fiq.c still doesn't compile
Message-ID: <20060120212635.GC31803@stusta.de>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120031555.7b6d65b7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 03:15:55AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm1:
>...
> +arm26-fixup-asm-statement-in-kernel-fiqc.patch
>...
>  arm25 fixes
>...

This doesn't seem to be enough to fix the arm27 compilation [1]:

<--  snip  -->

...
  CC      arch/arm26/kernel/fiq.o
/usr/src/ctest/mm/kernel/arch/arm26/kernel/fiq.c:1: note: future releases of GCC will not support -mapcs-26
/usr/src/ctest/mm/kernel/arch/arm26/kernel/fiq.c: In function `set_fiq_regs':
/usr/src/ctest/mm/kernel/arch/arm26/kernel/fiq.c:122: error: fp cannot be used in asm here
make[2]: *** [arch/arm26/kernel/fiq.o] Error 1

<--  snip  -->

cu
Adrian

[1] http://l4x.org/k/?d=10230

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

