Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273818AbRIXG4C>; Mon, 24 Sep 2001 02:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273815AbRIXGzy>; Mon, 24 Sep 2001 02:55:54 -0400
Received: from pD9519457.dip.t-dialin.net ([217.81.148.87]:50822 "HELO
	zaphod.khaberz.de") by vger.kernel.org with SMTP id <S273818AbRIXGze>;
	Mon, 24 Sep 2001 02:55:34 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 compile failure
From: Kai Haberzettl <kai@khaberz.de>
Organization: private site
Date: Mon, 24 Sep 2001 08:55:55 +0200
Message-ID: <m3adzl9ix0.fsf@khaberz.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.5 (artichoke)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10 fails to compile for me (SuSE 7.1 System, gcc version 2.95.2)

Here's what I get:

make -C sound
make[2]: Entering directory `/usr/src/linux/drivers/sound'
make all_targets
make[3]: Entering directory `/usr/src/linux/drivers/sound'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -DEXPORT_SYMTAB -c sound_core.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o sound_firmware.o sound_firmware.c
ld -m elf_i386 -r -o soundcore.o sound_core.o sound_firmware.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o es1370.o es1370.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o es1371.o es1371.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-alias
ing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -DEXPORT_SYMTAB -c ac97_codec.c
rm -f sounddrivers.o
ld -m elf_i386  -r -o sounddrivers.o soundcore.o es1370.o es1371.o ac97_codec.o
es1371.o: In function `gameport_register_port':
es1371.o(.text+0x4df0): multiple definition of `gameport_register_port'
es1370.o(.text+0x4df8): first defined here
es1371.o: In function `gameport_unregister_port':
es1371.o(.text+0x4df4): multiple definition of `gameport_unregister_port'
es1370.o(.text+0x4dfc): first defined here
make[3]: *** [sounddrivers.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/sound'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/sound'
make[1]: *** [_subdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

