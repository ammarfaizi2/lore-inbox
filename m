Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbTCZLPn>; Wed, 26 Mar 2003 06:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTCZLPm>; Wed, 26 Mar 2003 06:15:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:195 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261522AbTCZLPl>; Wed, 26 Mar 2003 06:15:41 -0500
Date: Wed, 26 Mar 2003 12:26:49 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.66: compile problem with snd-ice1724
Message-ID: <20030326112648.GL24744@fs.tum.de>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 03:26:47PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.65 to v2.5.66
> ============================================
>...
> Jaroslav Kysela <perex@suse.cz>:
>   o ALSA update
>...

snd-ice1724 seems to be too much of a copy of snd-ice1712, trying to 
compile both into the kernel results in the following error:

<--  snip  -->

...
   ld -m elf_i386  -r -o sound/pci/ice1712/built-in.o 
sound/pci/ice1712/snd-ice1712.o sound/pci/ice1712/snd-ice1724.o
sound/pci/ice1712/snd-ice1724.o(.text+0x540): In function 
`snd_ice1712_akm4xxx_init':
: multiple definition of `snd_ice1712_akm4xxx_init'
sound/pci/ice1712/snd-ice1712.o(.text+0x7540): first defined here
sound/pci/ice1712/snd-ice1724.o(.text+0x2c0): In function 
`snd_ice1712_akm4xxx_reset':
: multiple definition of `snd_ice1712_akm4xxx_reset'
sound/pci/ice1712/snd-ice1712.o(.text+0x72c0): first defined here
sound/pci/ice1712/snd-ice1724.o(.text+0x8c0): In function 
`snd_ice1712_akm4xxx_build_controls':
: multiple definition of `snd_ice1712_akm4xxx_build_controls'
sound/pci/ice1712/snd-ice1712.o(.text+0x78c0): first defined here
sound/pci/ice1712/snd-ice1724.o(.text+0x0): In function 
`snd_ice1712_akm4xxx_write':
: multiple definition of `snd_ice1712_akm4xxx_write'
sound/pci/ice1712/snd-ice1712.o(.text+0x7000): first defined here
make[3]: *** [sound/pci/ice1712/built-in.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

