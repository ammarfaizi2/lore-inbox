Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263120AbTDBSvg>; Wed, 2 Apr 2003 13:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263121AbTDBSvg>; Wed, 2 Apr 2003 13:51:36 -0500
Received: from dsl-213-023-013-209.arcor-ip.net ([213.23.13.209]:32896 "EHLO
	spot.lan") by vger.kernel.org with ESMTP id <S263120AbTDBSve>;
	Wed, 2 Apr 2003 13:51:34 -0500
From: Oliver Feiler <kiza@gmx.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Nehal <nehal@canada.com>
Subject: Re: mount hfs on SCSI cdrom = segfault
Date: Wed, 2 Apr 2003 21:01:28 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3E87477C.3050208@canada.com> <3E8B28B9.5090400@canada.com> <20030402104922.737d2ae9.rddunlap@osdl.org>
In-Reply-To: <20030402104922.737d2ae9.rddunlap@osdl.org>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_UOzi+MBLTeOTa+B";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304022101.40921.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_UOzi+MBLTeOTa+B
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

is this the same problem as this one?
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D102890250915062&w=3D2

Nobody ever answered on that, though.


On Wednesday 02 April 2003 12:49, Randy.Dunlap wrote:
> First post said Linux 2.4.20... that's good info.
> That info has been deleted from subsequent postings.
>
> Would it make sense for the BUG() message to include a kernel
> version number???  I'm wondering since people do omit that data.
>
> ~Randy
>
> On Wed, 02 Apr 2003 10:15:21 -0800 Nehal <nehal@canada.com> wrote:
> | > i have a hybrid cd (both HFS, ISO9660) , i have two CD drives,
> | > one IDE CD-Rom (actima 32x), and one SCSI CD-burner (yamaha 6416)
> | > on an advansys cfg-510 ISA scsi card
> | >
> | > when i try to mount on IDE using hfs with:
> | >
> | >    mount -v -r -t hfs /dev/hdc /cdrom
> | >
> | > it works fine, yet when i try on scsi with:
> | >
> | >    mount -v -r -t hfs /dev/scd0 /cdrom
> | >
> | > i get a "Segmentation fault" error, no more output given,
> | > it also locks the drive, and sometimes i can use the
> | > 'eject' command to eject it, sometimes i cant and i gotta reboot
> | >
> | > note: when i try to mount the cd using regular iso9660 fs, it
> | > works perfectly on both cd drives,
> | > also i have tried 2 hybrid cd's, both times i have trouble mounting
> | > hfs on the scsi drive only
> | >
> | > Nehal
> |
> | ok i updated firmware of writer from 1.0c to 1.0d with no help,
> | but i found when i do 'dmesg' after mounting i get this error:
> | =3D=3D=3D=3D=3D=3D=3D=3D
> | kernel BUG at buffer.c:2518!
> | invalid operand: 0000
> | CPU:    0
> | EIP:    0010:[<c013c329>]    Not tainted
> | EFLAGS: 00013206
> | eax: 000007ff   ebx: 00000b00   ecx: 00000800   edx: c11ee640
> | esi: 00000b00   edi: 00000200   ebp: 00000b00   esp: c3425db4
> | ds: 0018   es: 0018   ss: 0018
> | Process mount (pid: 514, stackpage=3Dc3425000)
> | Stack: c6d0d760 c3425e48 c0257a59 c7f1c574 00000000 00000b00 00000200
> | 00000000
> |        c0139f66 00000b00 00000000 00000200 00000000 00000001 c7568400
> | 00000000
> |        c013a1e0 00000b00 00000000 00000200 00000000 c019280a 00000b00
> | 00000000
> | Call Trace:    [<c0257a59>] [<c0139f66>] [<c013a1e0>] [<c019280a>]
> | [<c019188a>]
> |   [<c01925ff>] [<c0285c30>] [<c013cdca>] [<c013e908>] [<c013d64b>]
> | [<c013cd3c>]
> |   [<c013d9a1>] [<c014fcf3>] [<c0150020>] [<c014fe69>] [<c0150441>]
> | [<c01090ff>]
> |
> | Code: 0f 0b d6 09 9a 2b 33 c0 8d 87 00 fe ff ff 3d 00 0e 00 00 76
> |
> | root@Nehal:~#
> | =3D=3D=3D=3D=3D=3D=3D=3D
> | then when i try it again it doesnt give this message, it locks up my
> | drive
> |
> | can someone please help debug this problem,
> | thx, Nehal
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>
http://kiza.kcore.de/    <--    homepage
PGP-key      -->    /pgpkey.shtml
http://kiza.kcore.de/journal/

--Boundary-02=_UOzi+MBLTeOTa+B
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+izOUOpifZVYdT9IRAsboAJ9B88moBVBn4wqelKQCFgT8za9lIwCeKLGQ
E4fYD6KESOC1LLcKb47DtfI=
=U0+U
-----END PGP SIGNATURE-----

--Boundary-02=_UOzi+MBLTeOTa+B--

