Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSLCVaT>; Tue, 3 Dec 2002 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSLCVaS>; Tue, 3 Dec 2002 16:30:18 -0500
Received: from dhcp80ff2399.dynamic.uiowa.edu ([128.255.35.153]:55431 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S266296AbSLCVaR>;
	Tue, 3 Dec 2002 16:30:17 -0500
Date: Tue, 3 Dec 2002 15:37:48 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: [ALSA + OSS emul + CS4281] undefined references
Message-ID: <20021203213747.GA20164@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this while trying to compile 2.5.50.  I searched the available
  archives and didn't find anything, so I thought I'd post it.

make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (updated)
    gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasin
g -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwith
prefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
       ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
               ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  i
nit/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generi
c/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  li
b/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group 
 -o vmlinux
               sound/built-in.o(.text+0x1d1b8): In function `snd_rawmidi_dev_register':
               : undefined reference to `snd_seq_device_new'
               sound/built-in.o(.text+0x1e57c): In function `snd_opl3_hwdep_new':
               : undefined reference to `snd_seq_device_new'
               sound/built-in.o(.text+0x1eefb): In function `snd_opl3_synth_event_input':
               sound/built-in.o(.text+0x1f64b): In function `snd_opl3_note_on':
               : undefined reference to `snd_seq_instr_free_use'
               sound/built-in.o(.text+0x1fb40): In function `snd_opl3_note_on':
               : undefined reference to `snd_seq_instr_free_use'
               sound/built-in.o(.text+0x20257): In function `snd_opl3_oss_event_input':
               : undefined reference to `snd_midi_process_event'
               sound/built-in.o(.text+0x2026c): In function `snd_opl3_oss_free_port':
               : undefined reference to `snd_midi_channel_free_set'
               sound/built-in.o(.text+0x20293): In function `snd_opl3_oss_create_port':
               : undefined reference to `snd_midi_channel_alloc_set'
               sound/built-in.o(.text+0x20307): In function `snd_opl3_oss_create_port':
               : undefined reference to `snd_seq_event_port_attach'
               sound/built-in.o(.text+0x20321): In function `snd_opl3_oss_create_port':
               : undefined reference to `snd_midi_channel_free_set'
               sound/built-in.o(.text+0x2035c): In function `snd_opl3_init_seq_oss':
               : undefined reference to `snd_seq_device_new'
               sound/built-in.o(.text+0x2073f): In function `snd_opl3_load_patch_seq_oss':
               : undefined reference to `snd_seq_instr_event'
               sound/built-in.o(.text+0x207ab): In function `snd_opl3_load_patch_seq_oss':
               : undefined reference to `snd_seq_instr_event'
               sound/built-in.o(.init.text+0x611): In function `alsa_opl3_seq_init':
               : undefined reference to `snd_seq_device_register_driver'
               make: *** [vmlinux] Error 1

Hope this helps somebody.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"I use Linux and it makes me feel safer knowing exactly what security
 problems my boxen are facing. If I wanted filtered information or a public
 relations a** kissing, I'd use Microsoft products." --dattaway, on /.
