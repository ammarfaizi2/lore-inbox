Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRCaNnY>; Sat, 31 Mar 2001 08:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132384AbRCaNnO>; Sat, 31 Mar 2001 08:43:14 -0500
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:50264 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S132379AbRCaNm6>; Sat, 31 Mar 2001 08:42:58 -0500
Date: Sat, 31 Mar 2001 08:42:12 -0500
From: Karl Heinz Kremer <khk@khk.net>
To: linux-kernel@vger.kernel.org
Cc: khk@khk.net
Subject: IDE Disk Corruption with 2.4.3 / NOT with AC kernels
Message-ID: <20010331084212.A11393@khk.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I run into some major disk corruptions on my IDE disk with the new
2.4.3 kernel version. I did see the same corruptions with 2.4.2
- but back then I blamed reiserfs and went back to 2.4.1.

Now I did some more testing and found out that the Alan Cox=20
series of kernel patches does not show these problems. I tried
one from the 2.4.1-ac series (I think it was ac8) and 2.4.2-ac20
with nothing but success. I was using the same .config file for
all tests to make sure that the problem was not caused by=20
a kernel configuration issue.=20

This is my hardware:

	- ABit KT7 board (KT133 chipset reported by lspci)
	- 1GHz Athlon
	- QUANTUM FIREBALLP AS40.0 disk (cat /proc/ide/hda/model)

Here is the output of lspci:

khk@specht:~ > /sbin/lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (r=
ev 30)
00:09.0 Multimedia video controller: Zoran Corporation ZR36057PQC Video cut=
ting chipset (rev 02)
00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
00:0f.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
00:11.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev =
01)

I can provide more information on request, I can also test patches - I have=
 a test
partition that I'm using to test new kernel configurations without affectin=
g my
"normal" system.

I am following the list only through the archives on the web, so if you wan=
t to
get in touch with me, please CC khk@khk.net.

Karl Heinz


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.2

iQCVAwUBOsXesx4KmkKPBVxtAQEHQwP/ZFyoDfF730glWH6WGIlh0aW1kguJgLn3
mRpCEQtg5TzQR6jQBtsmsunGwJkulo8/61DRxMSlYaomW+vfKQYGOwoVENpr07B4
qRmaoHhOZTyKga/OC4fGM46MKdjUDniKgiH5OXAoWVi39HFW2LUD6A2k0PM4K/p1
lqWk2Q0ZTtc=
=kupF
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
