Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUKAP5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUKAP5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268873AbUKAP5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:57:45 -0500
Received: from kelvin.pobox.com ([207.8.226.2]:28392 "EHLO kelvin.pobox.com")
	by vger.kernel.org with ESMTP id S261845AbUKANsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:48:45 -0500
Date: Mon, 1 Nov 2004 06:48:28 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1: drivers/ide/ide-dma.o: value of -130 too large for
 field of 1 bytes at 911
Message-Id: <20041101064828.1d67078a.dickson@permanentmail.com>
In-Reply-To: <20041101121256.GK2495@stusta.de>
References: <20041101035402.556616d2.dickson@permanentmail.com>
	<20041101121256.GK2495@stusta.de>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 13:12:56 +0100, Adrian Bunk wrote:

> On Mon, Nov 01, 2004 at 03:54:02AM -0700, Paul Dickson wrote:
> > With the attached .config, I'm getting this while compiling...
> > 
> >...
> >   CC      drivers/ide/ide-dma.o
> > {standard input}: Assembler messages:
> > {standard input}:607: Error: value of -130 too large for field of 1 bytes at 911
> > make[3]: *** [drivers/ide/ide-dma.o] Error 1
> > make[2]: *** [drivers/ide] Error 2
> > make[1]: *** [drivers] Error 2
> > make: *** [bzImage] Error 2
> > 
> > I got the same error with 2.6.9 too.
> > 
> > GCC 3.2.2 and 3.4.1.
> > 
> > Has this been fixed since 2.6.10-rc1?  Searching my Linux-Kernel folder
> > didn't find a match.
> 
> I can't reproduce it with your .config in 2.6.10-rc1.
> 
> Please send the output of ./scripts/ver_linux .
> 

The problem does not occur if I unselect "Generic PCI bus-master DMA
support".

I'm also using 0=../out.router.20041030 for an external directory:
    make O=../out.router.20041030/ bzImage


>From the FC2 system:

Linux violet.pwd.internal 2.6.8-1.521 #1 Mon Aug 16 09:01:18 EDT 2004 i686 i686 i386 GNU/Linux
  
Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_es1968 snd_ac97_codec snd_pcm snd_page_alloc snd_timer gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore nfs lockd parport_pc lp parport autofs4 ide_cs ds yenta_socket pcmcia_core sunrpc 3c59x floppy sg scsi_mod microcode vfat fat dm_mod joydev uhci_hcd ext3 jbd



>From the RH9 system:

Linux red 2.4.20-18.9 #1 Thu May 29 07:08:16 EDT 2003 i686 athlon i386 GNU/Linux
  
Gnu C                  3.2.2
Gnu make               3.79.1
binutils               2.13.90.0.18
util-linux             2.11y
mount                  2.11y
module-init-tools      writing
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          2002------------->
reiser4progs           line
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         w83781d i2c-proc i2c-viapro i2c-core parport_pc lp parport nfsd lockd sunrpc iptable_filter ip_tables autofs 3c59x loop keybdev mousedev hid input usb-uhci usbcore ext3 jbd lvm-mod


	-Paul

