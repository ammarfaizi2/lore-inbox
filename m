Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbUCOJgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbUCOJgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:36:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35536 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262469AbUCOJgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:36:12 -0500
Date: Mon, 15 Mar 2004 10:36:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: 2.6.4-mm2: ALSA au88{1,2}0: multiply defined symbols
Message-ID: <20040315093608.GT14833@fs.tum.de>
References: <20040314172809.31bd72f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314172809.31bd72f7.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error in 2.6.4-mm2 comes from Linus' tree:

<--  snip  -->

...
  LD      sound/pci/au88x0/built-in.o
sound/pci/au88x0/snd-au8820.o(.bss+0x20): multiple definition of `mchannels'
sound/pci/au88x0/snd-au8810.o(.bss+0x20): first defined here
ld: Warning: size of symbol `mchannels' changed from 128 in 
sound/pci/au88x0/snd-au8810.o to 64 in sound/pci/au88x0/snd-au8820.o
sound/pci/au88x0/snd-au8820.o(.bss+0x60): multiple definition of `rampchs'
sound/pci/au88x0/snd-au8810.o(.bss+0xa0): first defined here
ld: Warning: size of symbol `rampchs' changed from 128 in 
sound/pci/au88x0/snd-au8810.o to 64 in sound/pci/au88x0/snd-au8820.o
sound/pci/au88x0/snd-au8830.o(.bss+0x20): multiple definition of `mchannels'
sound/pci/au88x0/snd-au8810.o(.bss+0x20): first defined here
ld: Warning: size of symbol `mchannels' changed from 64 in 
sound/pci/au88x0/snd-au8810.o to 128 in sound/pci/au88x0/snd-au8830.o
sound/pci/au88x0/snd-au8830.o(.bss+0xa0): multiple definition of `rampchs'
sound/pci/au88x0/snd-au8810.o(.bss+0xa0): first defined here
ld: Warning: size of symbol `rampchs' changed from 64 in 
sound/pci/au88x0/snd-au8810.o to 128 in sound/pci/au88x0/snd-au8830.o
sound/pci/au88x0/snd-au8830.o(.text+0x6970): In function 
`Vort3DRend_Initialize':
: multiple definition of `Vort3DRend_Initialize'
sound/pci/au88x0/snd-au8810.o(.text+0x58c0): first defined here
make[3]: *** [sound/pci/au88x0/built-in.o] Error 1

<--   snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

