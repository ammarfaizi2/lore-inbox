Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268842AbRHKUtk>; Sat, 11 Aug 2001 16:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268844AbRHKUtb>; Sat, 11 Aug 2001 16:49:31 -0400
Received: from adsl-64-160-145-247.dsl.lsan03.pacbell.net ([64.160.145.247]:57416
	"EHLO runner.pacbell.net") by vger.kernel.org with ESMTP
	id <S268842AbRHKUtS>; Sat, 11 Aug 2001 16:49:18 -0400
Message-Id: <200108112049.f7BKnYQ22817@runner.pacbell.net>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
From: rruth@computer.org
Subject: Kernel 2.4.8 make modules fails in emu10k1 
Reply-To: rruth@computer.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Aug 2001 13:49:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make bzImage worked

make modules failed when attempting to make a module for my Sound Blaster Live.

If you need to see my .config file, let me know.

Here is the output from the 'end' of my make modules:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.8/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4.8/include/linux/modversions.h   -c -o voicemgr.o voicemgr.c
rm -f emu10k1.o
ld -m elf_i386  -r -o emu10k1.o audio.o cardmi.o cardmo.o cardwi.o cardwo.o 
ecard.o efxmgr.o emuadxmg.o hwaccess.o irqmgr.o joystick.o main.o midi.o 
mixer.o passthrough.o recmgr.o timer.o voicemgr.o
main.o(.modinfo+0x40): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in main.o
main.o(.modinfo+0xa0): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96 in 
main.o
main.o: In function `init_module':
main.o(.text+0x1880): multiple definition of `init_module'
joystick.o(.text+0x210): first defined here
main.o: In function `cleanup_module':
main.o(.text+0x18c0): multiple definition of `cleanup_module'
joystick.o(.text+0x250): first defined here
make[3]: *** [emu10k1.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.8/drivers/sound/emu10k1'
make[2]: *** [_modsubdir_emu10k1] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.8/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.8/drivers'
make: *** [_mod_drivers] Error 2


Richard
rruth@computer.org



