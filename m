Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbTBPQip>; Sun, 16 Feb 2003 11:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTBPQip>; Sun, 16 Feb 2003 11:38:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:211 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267203AbTBPQio>; Sun, 16 Feb 2003 11:38:44 -0500
Date: Sun, 16 Feb 2003 17:48:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: jsimmons@infradead.org, geert@linux-m68k.org,
       linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.61: drivers/video: multiple definition of linux_logo*
Message-ID: <20030216164835.GD20159@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error while compiling 2.5.61:

<--  snip  -->

...
   ld -m elf_i386  -r -o drivers/video/built-in.o 
drivers/video/console/built-in.o drivers/video/fbmem.o 
drivers/video/fbmon.o drivers/video/fbcmap.o drivers/video/modedb.o 
drivers/video/softcursor.o drivers/video/aty128fb.o 
drivers/video/cfbfillrect.o drivers/video/cfbcopyarea.o 
drivers/video/cfbimgblt.o drivers/video/radeonfb.o drivers/video/neofb.o 
drivers/video/tdfxfb.o drivers/video/tridentfb.o drivers/video/vesafb.o 
drivers/video/vga16fb.o drivers/video/vgastate.o 
drivers/video/riva/built-in.o drivers/video/aty/built-in.o 
drivers/video/i810/built-in.o drivers/video/hgafb.o drivers/video/vfb.o 
drivers/video/sstfb.o
drivers/video/hgafb.o(.init.data+0x0): multiple definition of 
`linux_logo_red'
drivers/video/fbmem.o(.init.data+0x0): first defined here
drivers/video/hgafb.o(.init.data+0xbb): multiple definition of 
`linux_logo_green'
drivers/video/fbmem.o(.init.data+0xbb): first defined here
drivers/video/hgafb.o(.init.data+0x176): multiple definition of 
`linux_logo_blue'
drivers/video/fbmem.o(.init.data+0x176): first defined here
drivers/video/hgafb.o(.init.data+0x231): multiple definition of 
`linux_logo'
drivers/video/fbmem.o(.init.data+0x231): first defined here
drivers/video/hgafb.o(.init.data+0x1b31): multiple definition of 
`linux_logo_bw'
drivers/video/fbmem.o(.init.data+0x1b31): first defined here
drivers/video/hgafb.o(.init.data+0x1e51): multiple definition of 
`linux_logo16'
drivers/video/fbmem.o(.init.data+0x1e51): first defined here
make[2]: *** [drivers/video/built-in.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

