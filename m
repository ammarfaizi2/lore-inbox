Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUA3Cn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 21:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbUA3Cn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 21:43:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15087 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266365AbUA3Cny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 21:43:54 -0500
Date: Fri, 30 Jan 2004 03:43:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: dbrownell@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.4.25-pre8: usb/gadget/file_storage.c doesn't compile with gcc 2.95
Message-ID: <20040130024350.GD3004@fs.tum.de>
References: <Pine.LNX.4.58L.0401291833160.1304@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401291833160.1304@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 06:41:52PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.25-pre7 to v2.4.25-pre8
> ============================================
>...
> David Brownell:
>...
>   o USB gadget: add file_storage gadget driver [2/7]
>...

I'm getting the following compile error with gcc 2.95:


<--  snip  -->

...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-modular/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6 
-DMODULE -DMODVERSIONS -include 
/home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-modular/include/linux/modversions.h  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=file_storage  -c -o 
file_storage.o file_storage.c
file_storage.c: In function `received_cbi_adsc':
file_storage.c:1385: parse error before `;'
file_storage.c: In function `check_parameters':
file_storage.c:3767: parse error before `;'
file_storage.c: In function `fsg_bind':
file_storage.c:3912: parse error before `;'
make[2]: *** [file_storage.o] Error 1
make[2]: Leaving directory 
`/home/bunk/linux/kernel-2.4/linux-2.4.25-pre8-modular/drivers/usb/gadget'

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

