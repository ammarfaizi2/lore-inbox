Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWDGRvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWDGRvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGRvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:51:09 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:7046 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932336AbWDGRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:51:08 -0400
Message-ID: <4436A60C.1020000@comcast.net>
Date: Fri, 07 Apr 2006 13:49:00 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DRM via bugs?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm not sure if this is mainline or ubuntu kernel and can't seem to find
any info on this (i.e. if it's known, fixed in 2.6.16, etc), so here's
some massive oopsen from my Athlon 64..


Feb 23 07:52:06 localhost kernel: [33790.181014] Oops: 0000 [1] PREEMPT SMP
Feb 23 07:52:06 localhost kernel: [33790.181017] CPU 0
Feb 23 07:52:06 localhost kernel: [33790.181020] Modules linked in:
af_packet nls_utf8 usb_storage rfcomm l2cap bluetooth powernow_k8
cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave
cpufreq_ondemand cpufreq_conservative via drm video tc1100_wmi sony_acpi
pcc_acpi hotkey dev_acpi container button acpi_sbs battery i2c_acpi_ec
ac nls_iso8859_1 nls_cp437 vfat fat ext2 dm_mod md_mod sr_mod sbp2
parport_pc lp parport ipv6 psmouse serio_raw snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul tsdev snd_seq_dummy
snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq i2c_viapro
snd_emu10k1 snd_rawmidi snd_ac97_codec
snd_ac97_bus usblp snd_pcm_oss snd_mixer_oss i2c_core pcspkr rtc
ohci1394 ieee1394 snd_pcm snd_seq_device snd_timer snd_page_alloc
snd_util_mem snd_hwdep snd 8139cp 8139too mii soundcore shpchp usbhid
pci_hotplug sg evdev xfs exportfs ehci_hcd uhci_hcd usbcore ide_generic
ide_cd cdrom generic via82cxxx sd_mod sata_via
libata scsi_mod thermal processor fan capability commoncap vga16fb cf
Feb 23 07:52:06 localhost kernel: copyarea vgastate cfbimgblt
cfbfillrect fbcon
tileblit font bitblit softcursor
Feb 23 07:52:06 localhost kernel: [33790.181069] Pid: 4204, comm: Xorg
Not tainted 2.6.15-15-amd64-k8 #1
Feb 23 07:52:06 localhost kernel: [33790.181072] RIP:
0010:[_end+134037098/2132357120] <ffffffff88440e6a>{:via:via_mmFreeMem+10}
Feb 23 07:52:06 localhost kernel: [33790.181081] RSP:
0018:ffff8100348fddf8 EFLAGS: 00010202
Feb 23 07:52:06 localhost kernel: [33790.181085] RAX: 0000000000000001
RBX: ffff8100382e0000 RCX: 0000000000000000
Feb 23 07:52:06 localhost kernel: [33790.181088] RDX: 0000000000000001
RSI: ffff8100348fde18 RDI: 0000000005fdc280
Feb 23 07:52:06 localhost kernel: [33790.181091] RBP: 0000000000000002
R08: 0000000000000001 R09: 0000000000000001
Feb 23 07:52:06 localhost kernel: [33790.181094] R10: 0000000000000000
R11: 0000000000000000 R12: 0000000000000001
Feb 23 07:52:06 localhost kernel: [33790.181099] R13: ffff8100348fde18
R14: ffff810035238800 R15: ffff810031bc0000
Feb 23 07:52:06 localhost kernel: [33790.181103] FS:
00002aaaab7acce0(0000) GS:ffffffff80426800(0000) knlGS:0000000000000000
Feb 23 07:52:06 localhost kernel: [33790.181107] CS: 0010 DS: 0000 ES:
0000 CR0: 000000008005003b
Feb 23 07:52:06 localhost kernel: [33790.181110] CR2: 0000000005fdc288
CR3: 0000000035625000 CR4: 00000000000006e0
Feb 23 07:52:06 localhost kernel: [33790.181115] Process Xorg (pid:
4204, threadinfo ffff8100348fc000, task ffff81003ab688e0)
Feb 23 07:52:06 localhost kernel: [33790.181117] Stack: ffff8100382e0000
ffffffff8844151a 0000000100000000 ffff81002b346688
Feb 23 07:52:06 localhost kernel: [33790.181126] 0000000005fdc280
ffff81003bcdb4c0 ffff810035238800 0000000000000021
Feb 23 07:52:06 localhost kernel: [33790.181132] ffff81003bcdb4c0
ffff81003523884c
Feb 23 07:52:06 localhost kernel: [33790.181136] Call
Trace:<ffffffff8844151a>{:via:via_final_context+202}
<ffffffff8842a5a0>{:drm:drm_rmctx+128}
Feb 23 07:52:06 localhost kernel: [33790.181191]
<ffffffff801ab64c>{mntput_no_expire+28} <ffffffff8842a520>{:drm:drm_rmctx+0}
Feb 23 07:52:06 localhost kernel: [33790.181215]
<ffffffff8842b365>{:drm:drm_ioctl+405} <ffffffff801a1a09>{do_ioctl+105}
Feb 23 07:52:06 localhost kernel: [33790.181240]
<ffffffff801a1ceb>{vfs_ioctl+683} <ffffffff801ab64c>{mntput_no_expire+28}
Feb 23 07:52:06 localhost kernel: [33790.181251]
<ffffffff801a1d8c>{sys_ioctl+108} <ffffffff8010fede>{system_call+126}
Feb 23 07:52:06 localhost kernel: [33790.181268]
Feb 23 07:52:06 localhost kernel: [33790.181281]
Feb 23 07:52:06 localhost kernel: [33790.181282] Code: 48 8b 4f 08 48 85
c9 0f 84 99 00 00 00 e9 9b 00 00 00 66 66
Feb 23 07:52:06 localhost kernel: [33790.181291] RIP
<ffffffff88440e6a>{:via:via_mmFreeMem+10} RSP <ffff8100348fddf8>
Feb 23 07:52:06 localhost kernel: [33790.181300] CR2: 0000000005fdc288
Feb 23 07:52:06 localhost kernel: [33790.181303] <1>Unable to handle
kernel paging request at 0000000005fdc288 RIP:
Feb 23 07:52:06 localhost kernel: [33790.187430]
<ffffffff88440e6a>{:via:via_mmFreeMem+10}
Feb 23 07:52:06 localhost kernel: [33790.187444] PGD 39181067 PUD
39182067 PMD 0



Something else that happened as well:

[ 1378.035582] agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
[ 1378.035596] agpgart: Xorg tried to set rate=x12. Setting to AGP3 x8 mode.
[ 1378.035601] agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
[ 1378.035640] agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[ 1378.252992] irq 201: nobody cared (try booting with the "irqpoll" option)
[ 1378.252998]
[ 1378.252999] Call Trace: <IRQ> <ffffffff80165aa5>{__report_bad_irq+53}
<ffffffff80165d1a>{note_interrupt+538}
[ 1378.253030] <ffffffff80165407>{__do_IRQ+215}
<ffffffff8011300f>{do_IRQ+47}
[ 1378.253052] <ffffffff80142af0>{ksoftirqd+0}
<ffffffff80110480>{ret_from_intr+0}
[ 1378.253061] <EOI> <ffffffff8030fd62>{thread_return+82}
<ffffffff8010e720>{default_idle+0}
[ 1378.253078] <ffffffff8010e758>{default_idle+56}
<ffffffff8010e846>{cpu_idle+150}
[ 1378.253090] <ffffffff80439895>{start_kernel+485}
<ffffffff80439286>{_sinittext+646}
[ 1378.253102]
[ 1378.253107] handlers:
[ 1378.253109] [<ffffffff8846c430>] (via_driver_irq_handler+0x0/0x170 [via])
[ 1378.253120] Disabling IRQ #201

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRDamCws1xW0HCTEFAQJI4BAAk8TcxM0WDcT0MD/tcz5X9mH/dRIYykeA
tu/fM4dHFVKE+URLw5kjlokP7B7GRK7qvvmmJhV0EbbBSU2eEMIxbEpbaqmuQOa0
fRMOdegc+uWmUDxqOBLp7Iz4G9rC/PxkEoo2uwBiEUEw3aq/nNylHx4kDANkmTQj
0nDUWXgwefmippnsoUiRXpAP/3ttaRSpnaxfdKi0VAeXRw4t632EP6RI2RV57d4Y
CobyujHzMtaZfO5S3WtnAJzCH9UWR+YJ1VUgjG01ndzy3KYC82irvXDQ2R9bnue6
LNwAxJH3Nm1SMdO8d21muo8P3ND6DlCtZiHe0YQzMTxaRjAvhJKDXePdJa8XQT73
ogyJ2cZhnJGLvWlNc/zvqnk/3KwH+6GIv15TmDHyEIounYRXDoYiutxBFWqVfUE7
MJ3oIVUbyZTNaSvYaw9ailewMBQS44bP8j5e53Ulh6a3TLKIcmpmLSfTG2oKSILd
T6KzGP3RDPd69vYZk9Jzyt4KWHaI786edDaNva0FrzxBQ53+a6atyEgdugP3zZEn
3Uq9eFPReDrslawODOJRgDr/9IKSNxLebRcPExxrS/PZPIDmVDVcfk9sUeSmHfq7
JqDi6tHyhw1ULh902sW86783sl/migRbxYc/qi1l7RKJ7hdtAtxfT7aS2d8dKIaJ
YJptBx7ONJM=
=cC5h
-----END PGP SIGNATURE-----
