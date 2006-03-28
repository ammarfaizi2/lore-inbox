Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWC1QQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWC1QQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWC1QQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:16:58 -0500
Received: from hs-grafik.net ([80.237.205.72]:57097 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751232AbWC1QQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:16:58 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Reiser4 bug
Date: Tue, 28 Mar 2006 18:16:43 +0200
User-Agent: KMail/1.9.1
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3164147.boInqyXV1G";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603281816.48367@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3164147.boInqyXV1G
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

reiser4 buged around, I think while trying to mount a ntfs partition:
=2D-----------[ cut here ]------------
kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:29!
invalid opcode: 0000 [#1]
PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:1d.7/usb4/idProduct
Modules linked in: ntfs ath_rate_sample wlan ath_hal irtty_sir sir_dev=20
ehci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<b01b2829>]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.16-mm1 #1)
EIP is at get_exclusive_access+0x35/0x3f
eax: cdf097c0   ebx: 00000000   ecx: dab5f894   edx: 00000000
esi: 00000000   edi: c7dd5fa4   ebp: 00000000   esp: c7dd5f0c
ds: 007b   es: 007b   ss: 0068
Process soffice.bin (pid: 6615, threadinfo=3Dc7dd4000 task=3Db0f2c030)
Stack: <0>b01b087f 00000000 dab5fb88 0000c000 b01420e7 e2f4acd4 ef739c80=20
b0146b5b
       e2f4a880 e2f4a874 dab5faec a3914000 e4f8c680 ef3b37c0 dab5f8ec ef69f=
b40
       dab5f894 00000000 0000bd18 00000001 dab5f8a0 00000071 00001000 0000b=
d18
Call Trace:
 [<b01b087f>] write_unix_file+0x1a4/0x527
 [<b01420e7>] vma_prio_tree_insert+0x17/0x2a
 [<b0146b5b>] vma_link+0x82/0x109
 [<b0155f8f>] vfs_write+0x8b/0x13f
 [<b01b06db>] write_unix_file+0x0/0x527
 [<b015687a>] sys_write+0x41/0x6a
 [<b0102c1b>] sysenter_past_esp+0x54/0x75
Code: 00 8b 80 a0 04 00 00 8b 40 40 8b 40 08 85 c0 75 1a ba 01 00 ff ff 89 =
c8=20
0f c1 10 85 d2 0f 85 ce 0d 00 00 c7 41 24 01 00 00 00 c3 <0f> 0b 1d 00 4c d=
3=20
45 b0 eb dc 89 c1 85 d2 75 19 b8 00 e0 ff ff

I'm not ccing the reiserfs list, because they reported my last mail as=20
spam....

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart3164147.boInqyXV1G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEKWFw/aHb+2190pERAiTfAKCtYf60mpazRTTbK1k/dYlyqq4wxQCaA9yA
H66zGWScqQjsR7YpnaVIAK4=
=z+xt
-----END PGP SIGNATURE-----

--nextPart3164147.boInqyXV1G--
