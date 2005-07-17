Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVGQWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVGQWPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVGQWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 18:15:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16912 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261436AbVGQWPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 18:15:20 -0400
Date: Mon, 18 Jul 2005 00:15:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: speedy <speedy@3d-io.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 compile error [ld: saa7134-core.c: undefined reference to `register_sound_dsp']
Message-ID: <20050717221517.GG3753@stusta.de>
References: <1787836434.20050717235339@3d-io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1787836434.20050717235339@3d-io.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 11:53:39PM +0200, speedy wrote:

> Hello linux-kernel,
> 
>       another link error, with different .config on a different box.
>       .config made with make menuconfig. Disabling the relevant
>       .config entries fixed the bug.
> 
>       p.s. please CC: me in the replies if any, as I'm not subscribed
>       to the list.
> 
>       p.s.2. I suppose Fedora core 4 GCC 4.0.0 is not recommended for
>       compiling the kernel? or not?

A recent gcc from the 3.3 or 3.4 branches is definitely less likely to 
cause problems. That said, problems are still unlikely with the compiler 
you are using.

> * tail of the compiler output:
>...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x2197ed): In function `saa7134_initdev':
> saa7134-core.c: undefined reference to `register_sound_dsp'
> drivers/built-in.o(.text+0x219823):saa7134-core.c: undefined reference to `register_sound_mixer'
> drivers/built-in.o(.text+0x21990e):saa7134-core.c: undefined reference to `unregister_sound_dsp'
> drivers/built-in.o(.text+0x219be6): In function `saa7134_finidev':
> saa7134-core.c: undefined reference to `unregister_sound_mixer'
> drivers/built-in.o(.text+0x219bef):saa7134-core.c: undefined reference to `unregister_sound_dsp'
> make: *** [.tmp_vmlinux1] Error 1
>...

Thanks for this report.
This is a known bug.

Workaround:

Say "Y" to
  Device Drivers
    Sound
      Sound card support

> Best regards,
>  speedy                          mailto:speedy@3d-io.com


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

