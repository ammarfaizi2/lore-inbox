Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264812AbUEEXaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbUEEXaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEEXaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:30:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40902 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264812AbUEEXaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:30:04 -0400
Date: Thu, 6 May 2004 01:29:58 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, dev@opensound.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc3-mm2: vermagic compile error if CONFIG_MODULES=n
Message-ID: <20040505232958.GB9636@fs.tum.de>
References: <20040505013135.7689e38d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.6-rc3-mm2:
>...
> +proc-sys-kernel-vermagic.patch
> 
>  Add /proc/sys/kernel/vermagic so that package installers can work out how
>  the kernel was built (soliciting feedback on this one).
>...

linux/vermagic.h now references a variable in kernel/module.c.

Since this file is only included for CONFIG_MODULES=y, CONFIG_MODULES=n 
results in the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
kernel/built-in.o(.data+0xc54): undefined reference to `vermagic'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

