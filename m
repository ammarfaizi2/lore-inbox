Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVAaQ0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVAaQ0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVAaQ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:26:53 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:276 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261257AbVAaQ0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:26:45 -0500
X-ME-UUID: 20050131162643627.991FE1C0024A@mwinf0606.wanadoo.fr
Subject: [Oops] 2.6.10: PREEMPT SMP
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 17:27:48 +0100
Message-Id: <1107188868.6675.29.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got this Oops with 2.6.10 (debian/sid stock kernel).

Kernel is tainted by VMWare, but it wasn't used (machine powered on
remotely and used just to run gaim though ssh). I can perhaps try to
reproduce it without it though if you need.

	Xav

Jan 31 14:08:01 bip kernel: c01c1447
Jan 31 14:08:01 bip kernel: PREEMPT SMP
Jan 31 14:08:01 bip kernel: Modules linked in: vmnet vmmon ipv6 lp thermal fan button processor ac battery nfs lockd sunrpc eth1394 af_packet eepro100 e100 ohci1394 ieee1394 snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc gameport uhci_hcd usbcore pci_hotplug
via_agp agpgart parport_pc parport floppy pcspkr rtc ext2 reiserfs tsdev mousedev evdev capability commoncap ide_cd cdrom psmouse via686a eeprom i2c_sensor i2c_isa i2c_viapro i2c_core 8139too mii ext3 jbd mbcache ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old opti621 ns87415 hpt366 ide_disk hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix fbcon font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect
Jan 31 14:08:01 bip kernel: CPU:    1
Jan 31 14:08:01 bip kernel: EIP:    0060:[__rb_rotate_left+7/64]    Tainted: P      VLI
Jan 31 14:08:01 bip kernel: EFLAGS: 00010286   (2.6.10-1-686-smp)
Jan 31 14:08:01 bip kernel: EIP is at __rb_rotate_left+0x7/0x40
Jan 31 14:08:01 bip kernel: eax: f1b8da60   ebx: da7f38e0   ecx: f58864a0   edx: 00000000
Jan 31 14:08:01 bip kernel: esi: f58864a0   edi: f1b8da60   ebp: c03b17a4   esp: eaa93ea0
Jan 31 14:08:01 bip kernel: ds: 007b   es: 007b   ss: 0068
Jan 31 14:08:01 bip kernel: Process cron (pid: 8568, threadinfo=eaa92000 task=f5b65a20)
Jan 31 14:08:01 bip kernel: Stack: c01c154f f58864a0 c03b17a4 da7f38e0 f1b8da6c f1b8da60 da7f38e0 c01a6d07
Jan 31 14:08:01 bip kernel:        da7f38e0 c03b17a4 eaa93f40 00000008 eaa93f4b ffffffea c01a6dfc 00000008
Jan 31 14:08:01 bip kernel:        ffffffff 00000000 0000000b 00000013 00000000 eaa93f40 ffffffff f60d20e0
Jan 31 14:08:01 bip kernel: Call Trace:
Jan 31 14:08:01 bip kernel:  [rb_insert_color+143/240] rb_insert_color+0x8f/0xf0
Jan 31 14:08:01 bip kernel:  [key_user_lookup+215/272] key_user_lookup+0xd7/0x110
Jan 31 14:08:01 bip kernel:  [key_alloc+92/800] key_alloc+0x5c/0x320
Jan 31 14:08:01 bip kernel:  [keyring_alloc+64/144] keyring_alloc+0x40/0x90
Jan 31 14:08:01 bip kernel:  [alloc_uid_keyring+74/192] alloc_uid_keyring+0x4a/0xc0
Jan 31 14:08:01 bip kernel:  [alloc_uid+199/384] alloc_uid+0xc7/0x180
Jan 31 14:08:01 bip kernel:  [set_user+19/144] set_user+0x13/0x90
Jan 31 14:08:01 bip kernel:  [sys_setuid+179/336] sys_setuid+0xb3/0x150
Jan 31 14:08:01 bip kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75



