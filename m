Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268068AbTAJA0g>; Thu, 9 Jan 2003 19:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268073AbTAJA0g>; Thu, 9 Jan 2003 19:26:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27900 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268068AbTAJA0c>; Thu, 9 Jan 2003 19:26:32 -0500
Date: Fri, 10 Jan 2003 01:35:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Simon G. Vogl" <simon@tk.uni-linz.ac.at>,
       linux-i2c@pelican.tk.uni-linz.ac.at, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.55: Two global symbols driver_lock
Message-ID: <20030110003514.GA6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.5.55:

<--  snip  -->

...
   ld -m elf_i386  -r -o drivers/built-in.o drivers/pci/built-in.o 
drivers/acpi/built-in.o drivers/pnp/built-in.o drivers/serial/built-in.o 
drivers/parport/built-in.o drivers/base/built-in.o 
drivers/char/built-in.o drivers/block/built-in.o drivers/misc/built-in.o 
drivers/net/built-in.o drivers/media/built-in.o drivers/atm/built-in.o 
drivers/ide/built-in.o drivers/scsi/built-in.o 
drivers/ieee1394/built-in.o drivers/cdrom/built-in.o 
drivers/video/built-in.o drivers/mtd/built-in.o 
drivers/pcmcia/built-in.o drivers/block/paride/built-in.o 
drivers/usb/built-in.o drivers/input/built-in.o 
drivers/input/gameport/built-in.o drivers/input/serio/built-in.o 
drivers/message/built-in.o drivers/i2c/built-in.o 
drivers/telephony/built-in.o drivers/md/built-in.o 
drivers/bluetooth/built-in.o drivers/hotplug/built-in.o 
drivers/mca/built-in.o
drivers/i2c/built-in.o(.data+0x14): multiple definition of `driver_lock'
drivers/net/built-in.o(.data+0xcf14): first defined here
ld: Warning: size of symbol `driver_lock' changed from 4 to 20 in 
drivers/i2c/built-in.o
make[1]: *** [drivers/built-in.o] Error 1

<--  snip  -->

The offending files are:
  drivers/i2c/i2c-core.c
  drivers/net/aironet4500_proc.c


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

