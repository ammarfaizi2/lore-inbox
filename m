Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTFGJzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFGJzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:55:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37593 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262931AbTFGJzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:55:06 -0400
Date: Sat, 7 Jun 2003 12:08:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, perex@suse.cz, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.70-mm5: sound/pcmcia/vx/snd-vx* multiple definitions
Message-ID: <20030607100836.GE15311@fs.tum.de>
References: <20030605021231.2b3ebc59.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605021231.2b3ebc59.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  LD      sound/pcmcia/vx/snd-vxpocket.o
  LD      sound/pcmcia/vx/snd-vxp440.o
  LD      sound/pcmcia/vx/built-in.o
sound/pcmcia/vx/snd-vxp440.o(.text+0x160): In function 
`snd_vxpocket_attach':
: multiple definition of `snd_vxpocket_attach'
sound/pcmcia/vx/snd-vxpocket.o(.text+0x160): first defined here
sound/pcmcia/vx/snd-vxp440.o(.data+0x1a0): multiple definition of 
`snd_vxpocket_ops'
sound/pcmcia/vx/snd-vxpocket.o(.data+0x1a0): first defined here
sound/pcmcia/vx/snd-vxp440.o(.text+0x420): In function 
`snd_vxpocket_detach':
: multiple definition of `snd_vxpocket_detach'
sound/pcmcia/vx/snd-vxpocket.o(.text+0x420): first defined here
sound/pcmcia/vx/snd-vxp440.o(.text+0x1320): In function 
`vx_set_mic_boost':
: multiple definition of `vx_set_mic_boost'
sound/pcmcia/vx/snd-vxpocket.o(.text+0x1320): first defined here
sound/pcmcia/vx/snd-vxp440.o(.text+0x4e0): In function 
`snd_vxpocket_detach_all':
: multiple definition of `snd_vxpocket_detach_all'
sound/pcmcia/vx/snd-vxpocket.o(.text+0x4e0): first defined here
sound/pcmcia/vx/snd-vxp440.o(.text+0x1a60): In function 
`vxp_add_mic_controls':
: multiple definition of `vxp_add_mic_controls'
sound/pcmcia/vx/snd-vxpocket.o(.text+0x1a60): first defined here
sound/pcmcia/vx/snd-vxp440.o(.text+0x14e0): In function 
`vx_set_mic_level':
: multiple definition of `vx_set_mic_level'
sound/pcmcia/vx/snd-vxpocket.o(.text+0x14e0): first defined here
make[3]: *** [sound/pcmcia/vx/built-in.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

