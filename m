Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRCNDzd>; Tue, 13 Mar 2001 22:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRCNDzW>; Tue, 13 Mar 2001 22:55:22 -0500
Received: from fepout2.telus.net ([199.185.220.237]:23768 "EHLO
	priv-edtnes04-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S131289AbRCNDzR>; Tue, 13 Mar 2001 22:55:17 -0500
From: jens <psh1@telus.net>
To: linux-kernel@vger.kernel.org
Subject: Sound problems with Asus K7V board using the via82cxxx drivers (2.4.3-pre 3/4)
Date: Tue, 13 Mar 2001 20:02:49 -0800
Message-ID: <2lqtatgk6dtbok94na6a4ss86aenevkkoh@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, I am not sure if this is a kernel problem or an operator
problem but for some reason or other my sound is no longer working.
More specifically when I run gmix it reports no mixers being found. I
verified that the via82cxxx driver is compiled in (it worked before)
and everything seems cosher. If anyone has a clue what would cause my
lack of sound, I would be grateful.

Jens


I noted two items of interest: 
During compile I get the following messages:
***************
/usr/bin/make -C sound
make[3]: Entering directory `/root/kernel2.4.2/linux/drivers/sound'
/usr/bin/make all_targets
make[4]: Entering directory `/root/kernel2.4.2/linux/drivers/sound'
gcc -D__KERNEL__ -I/root/kernel2.4.2/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DEXPORT_SYMTAB -c sound_core.c
gcc -D__KERNEL__ -I/root/kernel2.4.2/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-c -o sound_firmware.o sound_firmware.c
ld -m elf_i386 -r -o soundcore.o sound_core.o sound_firmware.o
gcc -D__KERNEL__ -I/root/kernel2.4.2/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-c -o via82cxxx_audio.o via82cxxx_audio.c
via82cxxx_audio.c: In function `via_ac97_reset':
via82cxxx_audio.c:1374: warning: unused variable `tmp8'
gcc -D__KERNEL__ -I/root/kernel2.4.2/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DEXPORT_SYMTAB -c ac97_codec.c
rm -f sounddrivers.o
ld -m elf_i386  -r -o sounddrivers.o soundcore.o via82cxxx_audio.o
ac97_codec.o
make[4]: Leaving directory `/root/kernel2.4.2/linux/drivers/sound'
make[3]: Leaving directory `/root/kernel2.4.2/linux/drivers/sound'

*****************

Note the 'unused variable 'tmp8' ' error


Also dmesg reports the following:
*************
Via 686a audio driver 1.1.14b
PCI: Found IRQ 10 for device 00:04.5
PCI: The same IRQ used for device 00:0a.0
ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299)
via82cxxx: board #1 at 0xA800, IRQ 10
*************


