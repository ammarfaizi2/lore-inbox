Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVILObi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVILObi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVILObi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:31:38 -0400
Received: from hs-grafik.net ([80.237.205.72]:59917 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751045AbVILObh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:31:37 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: reiser4 oops while mounting
Date: Mon, 12 Sep 2005 16:31:08 +0200
User-Agent: KMail/1.8.1
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1963182.jgoCx8jc4H";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509121631.11170@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1963182.jgoCx8jc4H
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I just tried to mount my external usb hdd (encrpyted).
  Vendor: USB 2.0   Model: Storage Device    Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: assuming drive cache: write through
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: assuming drive cache: write through
 sda: sda1 sda2
Attached scsi disk sda at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
attempt to access beyond end of device
dm-0: rw=3D0, want=3D58662920, limit=3D58588992
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018b7e4
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: aes_i586 cfq_iosched irtty_sir sir_dev ath_rate_sample w=
lan=20
ath_hal ehci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<c018b7e4>]    Tainted: P      VLI
EFLAGS: 00010206   (2.6.13-rc2-mm1)
EIP is at znodes_tree_done+0x16/0x26d
eax: f429f014   ebx: 00000000   ecx: 00002000   edx: c057cf88
esi: 00000000   edi: f429f038   ebp: f429f014   esp: f766ddc4
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 4670, threadinfo=3Df766c000 task=3Df3d4d020)
Stack: c03fe7b5 00000001 00000000 f429f000 f429f014 f7461a00 c019283b f429f=
000
       f7461a00 f429f000 0000000c c01a8760 c04794d8 00000000 c01a8948 00000=
00c
       fffffffb 00000000 00000000 c01a89a6 00000000 f7461a00 4b1b5d0b 00000=
000
Call Trace:
 [<c03fe7b5>] wait_for_completion+0x86/0xfa
 [<c019283b>] done_tree+0x48/0x9d
 [<c01a8760>] _done_formatted_fake+0x17/0x25
 [<c01a8948>] done_super+0x1b/0x2a
 [<c01a89a6>] reiser4_fill_super+0x4f/0x69
 [<c0159d6d>] get_sb_bdev+0xcd/0x10a
 [<c016dacc>] alloc_vfsmnt+0x7c/0xa3
 [<c01a46ee>] reiser4_get_sb+0x18/0x1d
 [<c01a8957>] reiser4_fill_super+0x0/0x69
 [<c0159f10>] do_kern_mount+0x38/0xac
 [<c016ea95>] do_new_mount+0x73/0x96
 [<c016f12d>] do_mount+0x129/0x165
 [<c016efbb>] copy_mount_options+0x4d/0x96
 [<c016f586>] sys_mount+0x77/0xb3
 [<c0102e0b>] sysenter_past_esp+0x54/0x75
Code: 31 c0 f3 ab 5b 5e 5f 5d c3 89 c2 a1 e8 8e 58 c0 e9 c4 30 fb ff 55 57 =
56=20
53 83 ec 08 89 c5 8d 78 24 8b 4f 04 85 c9 74 5b 8b 70 24 <8b> 16 31 c0 85 d=
2=20
0f 84 d3 00 00 00 8b 5a 1c 85 db 0f 84 cd 01

Any new mount command hangs...

I'm currently not subscribed to lkml, as I'll be on holiday in a few hours,=
 so=20
pleas cc me.
kernel is 2.6.13-rc2-mm1
Problem does not seem to be reproducable.

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart1963182.jgoCx8jc4H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJZEv/aHb+2190pERAvxrAJ9nOktFJi9r+6tgX+aU/aJ6fCJ79wCfY0xz
IOCFWeQ6pZyPz/quKoRC0v4=
=ZnIK
-----END PGP SIGNATURE-----

--nextPart1963182.jgoCx8jc4H--
