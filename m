Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRHKNQg>; Sat, 11 Aug 2001 09:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbRHKNQ0>; Sat, 11 Aug 2001 09:16:26 -0400
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:32321 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266982AbRHKNQP>; Sat, 11 Aug 2001 09:16:15 -0400
Date: Sat, 11 Aug 2001 14:16:24 +0100 (BST)
From: Peter Oliver <p.d.oliver@mavit.freeserve.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: problem compiling 2.4.8 with emu10k1
Message-ID: <Pine.LNX.4.30.0108111251020.859-100000@froglet.mavit.dnsalias.org>
X-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unable to compile kernel 2.4.8 with emu10k1 sound support enabled as a
module. My compiler is egcs-2.91.66, and my binutils is 2.9.1.0.23. I get
the following errors at the 'make modules' stage:

ld -m elf_i386  -r -o emu10k1.o audio.o cardmi.o cardmo.o cardwi.o
cardwo.o ecard.o efxmgr.o emuadxmg.o hwaccess.o irqmgr.o joystick.o main.o
midi.o mixer.o passthrough.o recmgr.o timer.o voicemgr.o
main.o(.modinfo+0x40): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in
main.o
main.o(.modinfo+0xa0): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96
in main.o
main.o: In function `init_module':
main.o(.text+0x1a70): multiple definition of `init_module'
joystick.o(.text+0x2d0): first defined here
main.o: In function `cleanup_module':
main.o(.text+0x1ab0): multiple definition of `cleanup_module'
joystick.o(.text+0x310): first defined here
make[3]: *** [emu10k1.o] Error 1
make[3]: Leaving directory `/home/mavit/linux/drivers/sound/emu10k1'
make[2]: *** [_modsubdir_emu10k1] Error 2
make[2]: Leaving directory `/home/mavit/linux/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/home/mavit/linux/drivers'
make: *** [_mod_drivers] Error 2

If I choose to build emu10k1 not as a module, my kernel compiles, boots,
and uses sound fine.

I could build 2.4.6's emu10k1 support as a module without problems.

Incidentally, I downloaded a source snapshot from
http://opensource.creative.com/ a couple of weeks ago, and was able to
build that into a module without difficulty.

I'm not subscribed to the list, so if you need any further information
you'll need to CC me.

-- 
Peter Oliver


