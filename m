Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319304AbSIKUAP>; Wed, 11 Sep 2002 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319305AbSIKUAP>; Wed, 11 Sep 2002 16:00:15 -0400
Received: from ulima.unil.ch ([130.223.144.143]:30343 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319304AbSIKUAM>;
	Wed, 11 Sep 2002 16:00:12 -0400
Date: Wed, 11 Sep 2002 22:05:01 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Can't link 2.5.34 (ISDN)
Message-ID: <20020911200501.GC22435@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after make mrproper, install the config file from 2.4.20-pre5-ac3 and
make oldconfig, the result of:
make dep && make bzImage && make modules is:

make[1]: Leaving directory `/usr/src/linux-2.5/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds.s -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o /usr/src/linux-2.5/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `deflect_timer_expire':
drivers/built-in.o(.text+0xbdfb3): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbdfb8): undefined reference to `cli'
drivers/built-in.o(.text+0xbdfd4): undefined reference to `restore_flags'
drivers/built-in.o(.text+0xbdff6): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbdffb): undefined reference to `cli'
drivers/built-in.o(.text+0xbe032): undefined reference to `restore_flags'
drivers/built-in.o(.text+0xbe069): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe06e): undefined reference to `cli'
drivers/built-in.o: In function `cf_command':
drivers/built-in.o(.text+0xbe22a): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe22f): undefined reference to `cli'
drivers/built-in.o(.text+0xbe248): undefined reference to `restore_flags'
drivers/built-in.o(.text+0xbe300): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe305): undefined reference to `cli'
drivers/built-in.o(.text+0xbe321): undefined reference to `restore_flags'
drivers/built-in.o: In function `deflect_extern_action':
drivers/built-in.o(.text+0xbe4f0): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe4f5): undefined reference to `cli'
drivers/built-in.o(.text+0xbe522): undefined reference to `restore_flags'
drivers/built-in.o: In function `insertrule':
drivers/built-in.o(.text+0xbe5d7): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe5dc): undefined reference to `cli'
drivers/built-in.o(.text+0xbe635): undefined reference to `restore_flags'
drivers/built-in.o: In function `deleterule':
drivers/built-in.o(.text+0xbe694): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe699): undefined reference to `cli'
drivers/built-in.o(.text+0xbe6d8): undefined reference to `restore_flags'
drivers/built-in.o(.text+0xbe715): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe71a): undefined reference to `cli'
drivers/built-in.o(.text+0xbe735): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_divert_icall':
drivers/built-in.o(.text+0xbe81f): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbe824): undefined reference to `cli'
drivers/built-in.o(.text+0xbe84d): undefined reference to `restore_flags'
drivers/built-in.o(.text+0xbea56): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbea5b): undefined reference to `cli'
drivers/built-in.o(.text+0xbea77): undefined reference to `restore_flags'
drivers/built-in.o: In function `deleteprocs':
drivers/built-in.o(.text+0xbecac): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbecb1): undefined reference to `cli'
drivers/built-in.o(.text+0xbecf6): undefined reference to `restore_flags'
drivers/built-in.o: In function `prot_stat_callback':
drivers/built-in.o(.text+0xbf228): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbf22d): undefined reference to `cli'
drivers/built-in.o(.text+0xbf272): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_divert_stat_callback':
drivers/built-in.o(.text+0xbf3f9): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbf3fe): undefined reference to `cli'
drivers/built-in.o(.text+0xbf435): undefined reference to `restore_flags'
drivers/built-in.o: In function `deflect_timer_expire':
drivers/built-in.o(.text+0xbe09f): undefined reference to `restore_flags'
drivers/built-in.o: In function `isdn_divert_ioctl':
drivers/built-in.o(.text+0xbf9e1): undefined reference to `save_flags'
drivers/built-in.o(.text+0xbf9e6): undefined reference to `cli'
drivers/built-in.o(.text+0xbf9fc): undefined reference to `restore_flags'
make: *** [vmlinux] Error 1
243.360u 18.960s 5:03.58 86.4%	0+0k 0+0io 1209762pf+0w
Exit 2

I haden't noticed this problem being reported to this ml, but maybe I am
wrong, in that case, I am sorry ;-)

I have changed to the new API for ISDN, and every thing got perfectly
compiled (but I am not sure if I will be able to use my ISDN with the
new CAPI...).

Have a nice day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
