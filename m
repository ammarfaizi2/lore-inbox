Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVHWFns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVHWFns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 01:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVHWFns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 01:43:48 -0400
Received: from www.pro-linux.de ([213.239.211.178]:54230 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S1751327AbVHWFnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 01:43:47 -0400
Date: Tue, 23 Aug 2005 07:43:34 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: Process in D state with st driver
Message-ID: <20050823054333.GA3360@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I do nightly backups on tape. Every 3 to 4 weeks a process is stuck in
D state while accessing the drive:

12398 ?        D      0:00 /usr/sbin/amcheck -ms daily

There are no messages in the log. Only a reboot can remove this process.

lsscsi --long
[0:0:0:0]    tape    TANDBERG  TDC 4222        =3D07:  /dev/st0
  state=3Drunning queue_depth=3D1 scsi_level=3D3 type=3D1 device_blocked=3D=
0 timeout=3D300

lsscsi --hosts --long
[0]    tmscsim
  cmd_per_lun=3D1    host_busy=3D0    sg_tablesize=3D255  unchecked_isa_dma=
=3D0

Kernel: 2.6.12.2 SMP

lspci
0000:00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev =
03)
0000:00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (=
rev 01)
0000:00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
0000:00:11.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [=
PCscsi] (rev 10)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine] =
(rev 06)

cat /proc/interrupts
           CPU0       CPU1
  0: 1753859899  436965002    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  3:          3          0    IO-APIC-edge  serial
  8:        106          0    IO-APIC-edge  rtc
 14:   18946860          6    IO-APIC-edge  ide0
 18:   88008860   86047094   IO-APIC-level  eth0
 19:   61084709          1   IO-APIC-level  tmscsim
NMI:          0          0
LOC: 2190883256 2191052965
ERR:          0
MIS:          0

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCreFLbySPj3b3eoRAigaAJ4rK745WO/AA+su+FvpDzm6ADlxbgCfRQyR
WKkJX8xI/QkcMuObonMzMJ4=
=p3lD
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
