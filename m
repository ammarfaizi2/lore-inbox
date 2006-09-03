Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWICQA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWICQA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 12:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWICQA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 12:00:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751343AbWICQA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 12:00:57 -0400
Date: Sun, 3 Sep 2006 12:00:55 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: unexplained backtrace during boot.
Message-ID: <20060903160055.GA3775@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is odd. It looks like an oops, but there's no header
explaining why this happened during boot..

(Seen on 2.6.18rc5-git1)

		Dave

EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sdb1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev sda1, type vfat), uses genfs_contexts
Adding 1011484k swap on /swapfile.  Priority:-1 extents:4125 across:1064392k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
CPU 0:
Modules linked in: vfat fat dm_mirror dm_mod video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport snd_intel8x0 snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_seq_dummy snd_ac97_bus snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_seq_device snd_pcm floppy snd_util_mem e1000 e752x_edac snd_timer i2c_i801 edac_mc snd_hwdep sg snd i2c_core snd_page_alloc ide_cd shpchp soundcore pcspkr emu10k1_gp gameport cdrom serio_raw raid0 ext3 jbd ata_piix libata usb_storage sd_mod scsi_mod ehci_hcd ohci_hcd uhci_hcd
Pid: 0, comm: swapper Not tainted 2.6.17-1.2608.fc6 #1
RIP: 0010:[<ffffffff8025a05c>]  [<ffffffff8025a05c>] mwait_idle+0x3f/0x54
RSP: 0018:ffffffff8096ff70  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff8096ff70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8057b0d0
RBP: ffffffff80578e80 R08: ffff810002617400 R09: 0000000000000001
R10: ffffffff804a273c R11: ffff810002617400 R12: 0000000000000001
R13: ffffffff80578e80 R14: ffffffff8096e000 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffffffff8093d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaacca0a0 CR3: 000000003f9b1000 CR4: 00000000000006e0
Call Trace:
 [<ffffffff8096e000>] init_thread_union+0x0/0x2000
DWARF2 unwinder stuck at init_thread_union+0x0/0x2000
Leftover inexact backtrace:
 [<ffffffff802673d2>] trace_hardirqs_on_thunk+0x35/0x37
 [<ffffffff80267409>] trace_hardirqs_off_thunk+0x35/0x67
 [<ffffffff80261878>] call_softirq+0x1c/0x28
 [<ffffffff802129f0>] __do_softirq+0xec/0xf5
 [<ffffffff804022d3>] serio_interrupt+0x29/0x86
 [<ffffffff802ad244>] module_text_address+0x16/0x3b
 [<ffffffff802305fa>] __wake_up+0x22/0x50
 [<ffffffff8028e178>] task_rq_lock+0x42/0x74
NET: Registered protocol family 10
lo: Disabled Privacy Extensions

-- 
http://www.codemonkey.org.uk

-- 
VGER BF report: U 0.5
