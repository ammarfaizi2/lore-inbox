Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVBHRzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVBHRzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVBHRzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:55:45 -0500
Received: from hydra.gt.owl.de ([195.71.99.218]:37807 "EHLO hydra.gt.owl.de")
	by vger.kernel.org with ESMTP id S261610AbVBHRzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:55:36 -0500
Date: Tue, 8 Feb 2005 18:55:29 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [OOps] 2.6.11-rc3 rmmod ide-scsi 
Message-ID: <20050208175529.GA28369@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
got this oops while unloading ide-scsi (rmmod segfaulted)

UP P4 1.7Ghz non Preempt, No HT, IDE DVD/CD-RW, IDE Disk, Vanilla
Kernel, (-chaos -> Debian make-kpkg --append-to-version=3D-chaos)

Linux chaos 2.6.11-rc3-chaos #1 Fri Feb 4 23:27:57 CET 2005 i686 GNU/Linux

Unable to handle kernel NULL pointer dereference at virtual address 000001e0
 printing eip:
e089e539
*pde =3D 00000000
Oops: 0000 [#1]
Modules linked in: nls_iso8859_1 isofs autofs4 nfs lockd sunrpc snd_ens1371=
 snd_rawmidi snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd=
 snd_page_alloc e100 i2c_i801 i2c_core evdev usbhid uhci_hcd usbcore intel_=
agp agpgart sr_mod cdrom dm_mod ide_scsi scsi_mod eepro100 mii
CPU:    0
EIP:    0060:[<e089e539>]    Not tainted VLI
EFLAGS: 00010002   (2.6.11-rc3-chaos)=20
EIP is at idescsi_queue+0x119/0x400 [ide_scsi]
eax: 00000000   ebx: c0971a40   ecx: e08c4a30   edx: dedf8b00
esi: 00001388   edi: c044e234   ebp: dedf8b54   esp: c910dc94
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 11757, threadinfo=3Dc910c000 task=3Dc9eec510)
Stack: dffef380 00000020 00000010 c0971a40 dedf8b00 d9546cb0 dedf8b68 deffc=
d80=20
       000001d4 c044e234 00000293 dedf8b00 ded25400 00000000 e08c47cf dedf8=
b00=20
       e08c4a30 e08c76d0 dedf8b88 dedf8b00 df692c00 ded25400 c1583030 e08ca=
a9a=20
Call Trace:
 [<e08c47cf>] scsi_dispatch_cmd+0x16f/0x250 [scsi_mod]
 [<e08c4a30>] scsi_done+0x0/0x30 [scsi_mod]
 [<e08c76d0>] scsi_times_out+0x0/0xc0 [scsi_mod]
 [<e08caa9a>] scsi_request_fn+0x1ca/0x380 [scsi_mod]
 [<c0233858>] __elv_add_request+0x78/0xc0
 [<c0236446>] blk_insert_request+0xa6/0xd0
 [<e08c97b8>] scsi_insert_special_req+0x38/0x40 [scsi_mod]
 [<e08c9a28>] scsi_wait_req+0x68/0xa0 [scsi_mod]
 [<e08c9960>] scsi_wait_done+0x0/0x60 [scsi_mod]
 [<e08a3462>] sr_do_ioctl+0x92/0x2a0 [sr_mod]
 [<e08a3155>] sr_packet+0x25/0x40 [sr_mod]
 [<e08e7a75>] cdrom_get_disc_info+0x65/0xb0 [cdrom]
 [<e08e372b>] cdrom_mrw_exit+0x1b/0x70 [cdrom]
 [<e08e3323>] unregister_cdrom+0x83/0xb0 [cdrom]
 [<e08a319a>] sr_kref_release+0x2a/0x50 [sr_mod]
 [<e08a3170>] sr_kref_release+0x0/0x50 [sr_mod]
 [<c01bf769>] kref_put+0x39/0xa0
 [<c01bed1f>] kobject_put+0x1f/0x30
 [<e08a31f9>] sr_remove+0x39/0x4b [sr_mod]
 [<e08a3170>] sr_kref_release+0x0/0x50 [sr_mod]
 [<c022e946>] device_release_driver+0x86/0x90
 [<c022ebc4>] bus_remove_device+0x64/0xb0
 [<c022d8cd>] device_del+0x5d/0xa0
 [<e08cda1f>] scsi_remove_device+0x4f/0xb0 [scsi_mod]
 [<e08ccaca>] scsi_forget_host+0x2a/0x50 [scsi_mod]
 [<e08c5319>] scsi_remove_host+0x19/0x80 [scsi_mod]
 [<e089e2dd>] idescsi_cleanup+0x4d/0x60 [ide_scsi]
 [<c024b95e>] ide_unregister_driver+0x5e/0x90
 [<c012f7f8>] try_stop_module+0x28/0x30
 [<e089edef>] exit_idescsi_module+0xf/0x11 [ide_scsi]
 [<c012f9b4>] sys_delete_module+0x144/0x180
 [<c0147500>] do_munmap+0xf0/0x160
 [<c01475b4>] sys_munmap+0x44/0x70
 [<c0102f33>] syscall_call+0x7/0xb
Code: 8b 54 24 3c 8b 42 64 89 53 2c 89 43 14 89 43 0c 8b 4c 24 40 89 4b 30 =
a1 a0 0d 35 c0 8b 72 3c 01 f0 89 43 38 8b 7c 24 24 8b 47 20 <8b> 80 e0 01 0=
0 00 a8 01 74 05 0f ba 6b 34 02 8b 43 1c 89 44 24=20

--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCCP0RUaz2rXW+gJcRAsn1AKDg1/L2LB6bM00bv6jlePxm9m0B7QCeOV+D
2jkEQXMJEqwaGbfbRLlueF4=
=lVg7
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
