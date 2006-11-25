Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966288AbWKYI7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966288AbWKYI7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966285AbWKYI7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:59:14 -0500
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:4014 "EHLO
	mta-2.ms.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S966284AbWKYI7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:59:13 -0500
Date: Sat, 25 Nov 2006 09:58:19 +0100
From: markus reichelt <ml@mareichelt.de>
Subject: Re: kobject_add failed with -EEXIST
In-reply-to: <4561E290.7060100@gmail.com>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20061125085819.GA3959@tatooine.rebelbase.local>
Organization: still stuck in reorganization mode
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=6c2NcOVqGQ03X4Wi
Content-disposition: inline
X-PGP-Key: 0xC2A3FEE4
X-PGP-Fingerprint: FFB8 E22F D2BC 0488 3D56  F672 2CCC 933B C2A3 FEE4
X-Request-PGP: http://mareichelt.de/keys/c2a3fee4.asc
References: <4561E290.7060100@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Jiri Slaby <jirislaby@gmail.com> wrote:

> Does anybody have some clue, what's wrong with the attached module?
> Kernel complains when the module is insmoded second time
> (DRIVER_DEBUG enabled):

no idea, but I got the same error msg during boot with a monolithic
2.6.18.3 (vanilla) when it comes to init of the sound hardware:


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

Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun
22 13:55:50 2006 UTC).
PCI: Enabling device 0000:02:0a.1 (0100 -> 0102)
ACPI: PCI Interrupt 0000:02:0a.1[A] -> Link [LNKA] -> GSI 19 (level,
low) -> IRQ 16
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LAUI] -> GSI 21 (level,
low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 60000 usecs
intel8x0: clocking to 55563
kobject_add failed for audio with -EEXIST, don't try to register
things with the same name in the same directory.
 [<c02bec1a>] kobject_add+0xf4/0xfa
 [<c039604d>] class_device_add+0x9d/0x286
 [<c03962bc>] class_device_create+0x76/0x8c
 [<c049c701>] sound_insert_unit+0xbd/0xd2
 [<c049c857>] register_sound_special_device+0xf8/0x100
 [<c02c1583>] vsnprintf+0x459/0x49a
 [<c04ae6cd>] snd_register_oss_device+0x107/0x15d
 [<c04c1e7e>] register_oss_dsp+0x35/0x57
 [<c02bf2d3>] kobject_uevent+0x348/0x350
 [<c04c1eca>] snd_pcm_oss_register_minor+0x2a/0xbe
 [<c04afa84>] snd_timer_dev_register+0xbe/0xc3
 [<c04ae1fb>] snd_device_register+0x32/0x53
 [<c04b91e1>] snd_pcm_timer_init+0xa9/0xdc
 [<c04b20a4>] snd_pcm_dev_register+0xf0/0x151
 [<c04b20ed>] snd_pcm_dev_register+0x139/0x151
 [<c04ae24a>] snd_device_register_all+0x2e/0x42
 [<c04ab5a6>] snd_card_register+0x9/0xaa
 [<c04c7dc4>] snd_intel8x0_probe+0x14e/0x171
 [<c0395455>] __driver_attach+0x0/0x59
 [<c02cc923>] pci_call_probe+0xa/0xc
 [<c02cc953>] __pci_device_probe+0x2e/0x3f
 [<c02cc982>] pci_device_probe+0x1e/0x30
 [<c03953b2>] driver_probe_device+0x44/0x95
 [<c039548b>] __driver_attach+0x36/0x59
 [<c0394b94>] bus_for_each_dev+0x35/0x59
 [<c03954bf>] driver_attach+0x11/0x13
 [<c0395455>] __driver_attach+0x0/0x59
 [<c0394f81>] bus_add_driver+0x52/0x81
 [<c02ccb07>] __pci_register_driver+0x37/0x47
 [<c04b22b5>] snd_pcm_notify+0x8c/0x91
 [<c077076b>] alsa_pcm_oss_init+0x61/0x6c
 [<c07506e4>] do_initcalls+0x53/0xe4
 [<c013e98b>] register_irq_proc+0x57/0x66
 [<c0184e68>] proc_mkdir_mode+0x37/0x49
 [<c0100295>] init+0x0/0x11f
 [<c01002cc>] init+0x37/0x11f
 [<c01012e1>] kernel_thread_helper+0x5/0xb
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

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFaAWrLMyTO8Kj/uQRApu0AJ9MaKtOxwSxTSX0eqgAGQXOR2fiqACff5Sl
O/nrxDR0NTRJ4xw/YwdqQMI=
=wibW
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

