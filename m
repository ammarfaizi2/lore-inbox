Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWCTKrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWCTKrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWCTKrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:47:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:1723 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932143AbWCTKrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:47:35 -0500
X-Authenticated: #2308221
Date: Mon, 20 Mar 2006 11:48:40 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hda errors on dmesg
Message-ID: <20060320104839.GA20646@hermes.uziel.local>
References: <20060318081134.M30026@linuxwireless.org> <17915ac50603180054l4c3c6646ifcdee47e8f76887c@mail.gmail.com> <20060319235255.M28695@linuxwireless.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20060319235255.M28695@linuxwireless.org>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alejandro,


On Sun, Mar 19, 2006 at 05:57:09PM -0600, Alejandro Bonilla wrote:
> Why am I getting hda errors when I don't even have a hda drive? Mine is s=
da.
> The syslog says is the kernel itself, no other application is causing thi=
s as
> I have stopped most services and still happen.
>=20
> dmesg
>=20
> [4295643.338000] ide: failed opcode was: 0xef=20
> [4295644.283000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq=
: 0x00=20
> [4295644.295000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq=
: 0x00=20
> [4295645.963000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq=
: 0x00=20
> [4295645.966000] hda: drive_cmd: status=3D0x51 { DriveReady SeekComplete =
Error }=20
> [4295645.966000] hda: drive_cmd: error=3D0x04 { AbortedCommand }=20
> [4295645.966000] ide: failed opcode was: 0xec=20
> [4295646.000000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq:=
 0x00=20
> [4295646.003000] hda: drive_cmd: status=3D0x51 { DriveReady SeekComplete =
Error }=20
> [4295646.003000 ] hda: drive_cmd: error=3D0x04 { AbortedCommand }=20
> [4295646.003000] ide: failed opcode was: 0xec=20
> [4295646.345000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq:=
 0x00=20
> [4295646.357000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq:=
 0x00=20
> [4295648.408000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq=
: 0x00=20
> [4295648.421000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq=
: 0x00=20
> [4295650.471000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30   ascq=
: 0x00=20
> [4295650.483000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq=
: 0x00=20
> [4295652.534000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq=
: 0x00=20
> [4295652.546000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30   ascq=
: 0x00=20
> [4295654.601000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq=
: 0x00=20
> [4295654.612000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq=
: 0x00
>
> Any idea?

Just an idea, but this looks to me like problems reading a CD - if you
use ide-cd and a normal parralel ATA / ATAPI CD-ROM drive, you might
have /dev/hda and a symlink pointing to that node as well. In this case,
you only care for e.g. /dev/cdrom, but in fact are using /dev/hda.


Regards,
Chris

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRB6Ihl2m8MprmeOlAQLN0BAArMs0CqNmU2MSKphRSEvUBSi+oCcZcPU5
JoJhul/GicUQPpieh+h2nsqorKsHrBEdIiW+p7rVrP1/8WMwj/3LLfw0grdZWDOx
YaVqlVQUG1JG0gxhe4cPZWn8PFM4NDizVOGOH70TWSCn9V5zgoQ63QseLvdFYCV/
B9ceGrDSxMqASzND6Zn6mihNFHXHWlHlBOhs4b0rJEL9NLtQEPL6VH4S7jtVrLVL
YwwHCQ6OdLyUG62YKtnIf8eMVp/ZLBuweHAttQy7ZVVrFuY+V4v69ounj/ZUXCCA
sq4oVTvrTlgVL6bUhyCdCk7muEONXGNz8M2gaxsv/o1xfPO3uIze/nz+22sk32+u
pscYAkSl2nk4xh7/RxydBRJaj8xTaw0GexlUGi//VPTfMCQSiK4dIIoYxdxESG79
55J6S3DoT/k1GMxuwruZDUICv+T28lCAWMsipNd8//UuW/V9pr6MOUaTXfk6bVjV
bHGqfi5NDg+FIh+tiTUHXLP5Frok6P29Bojin2eWtg0b/C5zvXKwJOyyaJIk1q7N
fmCZqivPeV8fz0/MckRGUth5Cx0oMDGuXUcBWyLg9zJCl38uZtDBlCj9y6Rmi+uW
astkHCZwON8AuVhx7QTYX3ZawudyKJss/fdQ6ixPo7FOU5OtwWEBsW+xEO4Dg1u9
ZBs1gwr1zXM=
=nhtv
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

