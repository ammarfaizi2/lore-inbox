Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUBOHlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUBOHlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:41:12 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56279 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264290AbUBOHlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:41:10 -0500
Date: Sun, 15 Feb 2004 08:41:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.3-rc3: twice defined symbols with new radeonfb
Message-ID: <20040215074106.GQ1308@fs.tum.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 07:33:45PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.3-rc2 to v2.6.3-rc3
> ============================================
>...
> Benjamin Herrenschmidt:
>...
>   o New radeonfb
>...

I'm getting the following compile error (no module support in the 
kernel):

<--  snip  -->

...
  LD      drivers/video/built-in.o
drivers/video/aty/built-in.o(.init.text+0x1560): In function 
`radeonfb_setup':
: multiple definition of `radeonfb_setup'
drivers/video/radeonfb.o(.init.text+0x20): first defined here
ld: Warning: size of symbol `radeonfb_setup' changed from 352 in 
drivers/video/radeonfb.o to 512 in drivers/video/aty/built-in.o
drivers/video/aty/built-in.o(.data+0xbc0): multiple definition of 
`common_regs_m6'
drivers/video/radeonfb.o(.data+0x4d4): first defined here
drivers/video/aty/built-in.o(.data+0xb78): multiple definition of 
`common_regs'
drivers/video/radeonfb.o(.data+0x48c): first defined here
drivers/video/aty/built-in.o(.exit.text+0x10): In function 
`radeonfb_exit':
: multiple definition of `radeonfb_exit'
drivers/video/radeonfb.o(.exit.text+0x0): first defined here
drivers/video/aty/built-in.o(.init.text+0x1530): In function 
`radeonfb_init':
: multiple definition of `radeonfb_init'
drivers/video/radeonfb.o(.init.text+0x0): first defined here
ld: Warning: size of symbol `radeonfb_init' changed from 24 in 
drivers/video/radeonfb.o to 34 in drivers/video/aty/built-in.o
make[2]: *** [drivers/video/built-in.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

