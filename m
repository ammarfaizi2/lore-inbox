Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269049AbRHLKTI>; Sun, 12 Aug 2001 06:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269057AbRHLKS7>; Sun, 12 Aug 2001 06:18:59 -0400
Received: from www2.mailru.com ([80.68.244.5]:10000 "EHLO www2.mailru.com")
	by vger.kernel.org with ESMTP id <S269049AbRHLKSr>;
	Sun, 12 Aug 2001 06:18:47 -0400
Message-ID: <3B7658A7.6050708@pisem.net>
Date: Sun, 12 Aug 2001 13:21:27 +0300
From: CuPoTKa <cupotka@pisem.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: ru, en-us, he
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        kbuild-devel <kbuild-devel@lists.sourceforge.net>,
        alan <alan@redhat.com>, kaos@ocs.com.au
Subject: Bug report : Build problem with kernel 2.4.8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: Can't compile kernel 2.4.8 with support of sound card CM8338A.

ver_linux script information:

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.24
util-linux             2.11h
mount                  2.11h
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    [ключи...]
Console-tools          0.2.3
Sh-utils               2.0.11
cat: /proc/modules: No such file or directory
Modules Loaded        


Errors i got:

make[4]: Entering directory `/usr/local/src/kernel-source-2.4.8/drivers/sound'
gcc -D__KERNEL__ -I/usr/local/src/kernel-source-2.4.8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o cmpci.o cmpci.c
In file included from cmpci.c:90:
/usr/local/src/kernel-source-2.4.8/include/linux/module.h:21: linux/modversions.h: No such file or directory
cmpci.c: In function `cm_release_mixdev':
cmpci.c:1594: warning: unused variable `s'
cmpci.c: In function `initialize_chip':
cmpci.c:3013: warning: unused variable `reg_mask'
make[4]: *** [cmpci.o] Error 1
make[4]: Leaving directory `/usr/local/src/kernel-source-2.4.8/drivers/sound'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/local/src/kernel-source-2.4.8/drivers/sound'
make[2]: *** [_subdir_sound] Error 2
make[2]: Leaving directory `/usr/local/src/kernel-source-2.4.8/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/usr/local/src/kernel-source-2.4.8'
make: *** [stamp-build] Error 2

Part of .config :

#
# Sound
#
CONFIG_SOUND=y
CONFIG_SOUND_CMPCI=y
# CONFIG_SOUND_CMPCI_FM is not set
# CONFIG_SOUND_CMPCI_MIDI is not set
# CONFIG_SOUND_CMPCI_JOYSTICK is not set
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
# CONFIG_SOUND_CMPCI_SPDIFLOOP is not set
CONFIG_SOUND_CMPCI_SPEAKERS=2
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

I use Debian GNU/Linux. Custom kernel 2.4.6 i686.

Best regards.

