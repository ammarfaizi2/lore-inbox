Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756821AbWLCQfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbWLCQfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756966AbWLCQfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:35:12 -0500
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:18908 "EHLO
	mta-2.ms.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S1756821AbWLCQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:35:10 -0500
Date: Sun, 03 Dec 2006 17:35:14 +0100
From: markus reichelt <ml@mareichelt.de>
Subject: 2.6.19: kobject_add failed with -EEXIST
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20061203163514.GA3869@tatooine.rebelbase.local>
Organization: still stuck in reorganization mode
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-disposition: inline
X-PGP-Key: 0xC2A3FEE4
X-PGP-Fingerprint: FFB8 E22F D2BC 0488 3D56  F672 2CCC 933B C2A3 FEE4
X-Request-PGP: http://mareichelt.de/keys/c2a3fee4.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I still have got the same problem during boot with monolithic vanilla
kernels 2.6.18.x & 2.6.19 when it comes to init of the sound
hardware. Please advise.

Linux tatooine 2.6.19 #1 PREEMPT Sun Dec 3 13:01:23 CET 2006 i686
athlon-4 i386 GNU/Linux

lspci

00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge
(rev a1)
00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev
a2)
00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management
(rev a1)
00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev
a1)
00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev
a1)
00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0
Controller (rev a2)
00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb
AC'97 Audio Controller (rev a1)
00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA
Controller (v2.5) (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI
Bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI
Bridge (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
02:06.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge
(non-transparent mode) (rev 15)
02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
02:0a.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
02:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA
G400/G450 (rev 85)


dmesg-snip

Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28
14:07:24 2006 UTC).
ACPI: PCI Interrupt 0000:02:0a.1[A] -> Link [LNKA] -> GSI 19 (level,
low) -> IRQ 16
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LAUI] -> GSI 21 (level,
low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 60001 usecs
intel8x0: clocking to 55385
kobject_add failed for audio with -EEXIST, don't try to register
things with the same name in the same directory.
 [<c02d6891>] kobject_add+0x107/0x110
 [<c03be821>] class_device_add+0xa3/0x2a9
 [<c03beab0>] class_device_create+0x79/0x8f
 [<c04cb69b>] sound_insert_unit+0xe8/0xfb
 [<c04cb808>] register_sound_special_device+0x111/0x119
 [<c04dde91>] snd_register_oss_device+0x107/0x15d
 [<c04f231d>] register_oss_dsp+0x4d/0x76
 [<c02d6fc0>] kobject_uevent+0x391/0x399
 [<c04f2373>] snd_pcm_oss_register_minor+0x2d/0xcc
 [<c02d940f>] vsnprintf+0x495/0x4d3
 [<c04df350>] snd_timer_dev_register+0xbe/0xc3
 [<c04dd9be>] snd_device_register+0x32/0x53
 [<c04e92b1>] snd_pcm_timer_init+0xc0/0xf3
 [<c04d9f9a>] snd_add_device_sysfs_file+0x4b/0x52
 [<c04e1c77>] snd_pcm_dev_register+0x181/0x199
 [<c04dda0d>] snd_device_register_all+0x2e/0x42
 [<c04da8d2>] snd_card_register+0x9/0xaa
 [<c04f853e>] snd_intel8x0_probe+0x170/0x195
 [<c02e4cb0>] pci_call_probe+0xa/0xc
 [<c02e4ce0>] __pci_device_probe+0x2e/0x3f
 [<c02e4d0f>] pci_device_probe+0x1e/0x30
 [<c03bda36>] really_probe+0x38/0xe0
 [<c02e4bf2>] pci_match_device+0xf/0xc3
 [<c03bdb96>] driver_probe_device+0xa3/0xaf
 [<c05a0cb0>] klist_next+0x52/0x8e
 [<c03bdc08>] __driver_attach+0x0/0x75
 [<c03bdc4c>] __driver_attach+0x44/0x75
 [<c03bd15c>] bus_for_each_dev+0x35/0x59
 [<c03bdc91>] driver_attach+0x14/0x16
 [<c03bdc08>] __driver_attach+0x0/0x75
 [<c03bd5df>] bus_add_driver+0x5a/0xe0
 [<c02e4f21>] __pci_register_driver+0x5d/0x6d
 [<c07ace3f>] alsa_pcm_oss_init+0x6e/0x7c
 [<c078a761>] do_initcalls+0x58/0xf5
 [<c018b7ce>] proc_mkdir_mode+0x3e/0x51
 [<c014229a>] register_irq_proc+0x5f/0x6b
 [<c0180000>] sys_ioprio_get+0x12a/0x182
 [<c010033d>] init+0x0/0x153
 [<c0100383>] init+0x46/0x153
 [<c01037b3>] kernel_thread_helper+0x7/0x10
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PM: Adding info for ac97:0-0:ALC850
ALSA device list:
  #0: NVidia CK8S with ALC850 at 0xfebfb000, irq 19
  #1: Brooktree Bt878 at 0xf57ff000, irq 16


 gcc -v

Reading specs from /usr/lib/gcc/i486-slackware-linux/3.4.6/specs
Configured with: ../gcc-3.4.6/configure --prefix=3D/usr --enable-shared
--enable-threads=3Dposix --enable-__cxa_atexit --disable-checking
--with-gnu-ld --verbose --target=3Di486-slackware-linux
--host=3Di486-slackware-linux
Thread model: posix
gcc version 3.4.6


--=20
left blank, right bald

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcvzCLMyTO8Kj/uQRAnV0AKCJEu41Cmd0jRJEzKVHVf3ebsTvGQCZAUdq
HEgWaflntzG0PpIY2fwX8EE=
=jleu
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

