Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSHGCTe>; Tue, 6 Aug 2002 22:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHGCTe>; Tue, 6 Aug 2002 22:19:34 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:35177 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id <S316677AbSHGCTd>; Tue, 6 Aug 2002 22:19:33 -0400
Date: Wed, 7 Aug 2002 04:23:09 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: 2.4.19 compile error   --- Speakup Speech
Message-Id: <20020807042309.160765af.stephane.wirtel@belgacom.net>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in my .config
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_ACNTSA=y
CONFIG_SPEAKUP_ACNTPC=y
CONFIG_SPEAKUP_APOLO=y
CONFIG_SPEAKUP_AUDPTR=y
CONFIG_SPEAKUP_BNS=y
CONFIG_SPEAKUP_DECTLK=y
CONFIG_SPEAKUP_DECEXT=y
CONFIG_SPEAKUP_DTLK=y
CONFIG_SPEAKUP_LTLK=y
CONFIG_SPEAKUP_SPKOUT=y
CONFIG_SPEAKUP_TXPRT=y
CONFIG_SPEAKUP_DEFAULT="none"
CONFIG_SPEAKUP_KEYMAP=y

my error is as follows :

make -C speakup
make[3]: Entering directory `/root/linux-2.4.19/drivers/char/speakup'
make all_targets
make[4]: Entering directory `/root/linux-2.4.19/drivers/char/speakup'
gcc -D__KERNEL__ -I/root/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=speakupmap  -c -o speakupmap.o speakupmap.c
rm -f spk.o
ld -m elf_i386  -r -o spk.o speakup.o speakup_drvcommon.o speakup_dtlk.o speakup_ltlk.o speakup_acntpc.o speakup_acntsa.o speakup_txprt.o speakup_bns.o speakup_audptr.o speakup_dectlk.o speakup_decext.o speakup_apolo.o speakup_spkout.o speakupmap.o
make[4]: Leaving directory `/root/linux-2.4.19/drivers/char/speakup'
make[3]: Leaving directory `/root/linux-2.4.19/drivers/char/speakup'
make all_targets
make[3]: Entering directory `/root/linux-2.4.19/drivers/char'
gcc -D__KERNEL__ -I/root/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=speakupmap  -c -o speakup/speakupmap.o speakup/speakupmap.c
rm -f char.o
ld -m elf_i386  -r -o char.o mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o vt.o vc_screen.o consolemap.o consolemap_deftbl.o console.o selection.o serial.o keyboard.o speakup/speakupmap.o pc_keyb.o sysrq.o speakup/spk.o
speakup/spk.o(.data+0xad80): multiple definition of `ctrl_map'
speakup/speakupmap.o(.data+0x300): first defined here
speakup/spk.o(.data+0xac80): multiple definition of `altgr_map'
speakup/speakupmap.o(.data+0x200): first defined here
speakup/spk.o(.data+0xb080): multiple definition of `alt_map'
speakup/speakupmap.o(.data+0x600): first defined here
speakup/spk.o(.data+0xb924): multiple definition of `funcbufleft'
speakup/speakupmap.o(.data+0xea4): first defined here
speakup/spk.o(.data+0xb180): multiple definition of `shift_alt_map'
speakup/speakupmap.o(.data+0x700): first defined here
speakup/spk.o(.data+0xb884): multiple definition of `func_buf'
speakup/speakupmap.o(.data+0xe04): first defined here
speakup/spk.o(.data+0xb280): multiple definition of `ctrl_alt_map'
speakup/speakupmap.o(.data+0x800): first defined here
speakup/spk.o(.data+0xb920): multiple definition of `funcbufsize'
speakup/speakupmap.o(.data+0xea0): first defined here
speakup/spk.o(.data+0xc040): multiple definition of `accent_table_size'
speakup/speakupmap.o(.data+0x15c0): first defined here
speakup/spk.o(.data+0xb91c): multiple definition of `funcbufptr'
speakup/speakupmap.o(.data+0xe9c): first defined here
speakup/spk.o(.data+0xb480): multiple definition of `key_maps'
speakup/speakupmap.o(.data+0xa00): first defined here
speakup/spk.o(.data+0xb380): multiple definition of `shift_ctrl_alt_map'
speakup/speakupmap.o(.data+0x900): first defined here
speakup/spk.o(.data+0xb880): multiple definition of `keymap_count'
speakup/speakupmap.o(.data+0xe00): first defined here
speakup/spk.o(.data+0xae80): multiple definition of `shift_ctrl_map'
speakup/speakupmap.o(.data+0x400): first defined here
speakup/spk.o(.data+0xaa80): multiple definition of `plain_map'
speakup/speakupmap.o(.data+0x0): first defined here
speakup/spk.o(.data+0xaf80): multiple definition of `altgr_ctrl_map'
speakup/speakupmap.o(.data+0x500): first defined here
speakup/spk.o(.data+0xb940): multiple definition of `func_table'
speakup/speakupmap.o(.data+0xec0): first defined here
speakup/spk.o(.data+0xab80): multiple definition of `shift_map'
speakup/speakupmap.o(.data+0x100): first defined here
speakup/spk.o(.data+0xbd40): multiple definition of `accent_table'
speakup/speakupmap.o(.data+0x12c0): first defined here
make[3]: *** [char.o] Error 1
make[3]: Leaving directory `/root/linux-2.4.19/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/root/linux-2.4.19/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/root/linux-2.4.19/drivers'
make: *** [_dir_drivers] Error 2
bash-2.05a#

Stéphane Wirtel
