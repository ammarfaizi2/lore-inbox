Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTANQAg>; Tue, 14 Jan 2003 11:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTANQAg>; Tue, 14 Jan 2003 11:00:36 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:15005 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S264630AbTANP74>;
	Tue, 14 Jan 2003 10:59:56 -0500
Date: Tue, 14 Jan 2003 11:08:47 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: um, bug in ??????
Message-ID: <20030114160847.GC13131@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



One of my systems just blew chunks while I happened to be watching the
console:

root@legato-disk6.acs
{0}:/proc/sys/dev/raid>skput:over: c020f938:6301 put:6301 dev:eth1kernel
BUG at skbuff.c:92!
invalid operand: 0000
CPU:    1           =20
EIP:    0010:[<c02b700b>]    Not tainted
EFLAGS: 00010286                       =20
eax: 0000002b   ebx: c020f938   ecx: 00000001   edx: 00000001
esi: 0000001a   edi: 00000020   ebp: c16e3560   esp: dffe9ea4
ds: 0018   es: 0018   ss: 0018                              =20
Process swapper (pid: 0, stackpage=3Ddffe9000)
Stack: c039e240 c020f938 0000189d 0000189d c16e3400 df04ea40 c020f940 df04e=
a40=20
       0000189d c020f938 00000020 c16e3400 00000040 0000e401 0000189d 00000=
020=20
       00000001 0000001f c842b89d 00001000 c020f170 c16e3400 df3249c0 04000=
001=20
Call Trace:    [<c020f938>] [<c020f940>] [<c020f938>] [<c020f170>] [<c010a4=
61>]
  [<c010a656>] [<c0106df0>] [<c010cc88>] [<c0106df0>] [<c0106e1c>] [<c0106e=
79>]
  [<c011abe9>] [<c011ae7f>]                                                =
   =20
                          =20
Code: 0f 0b 5c 00 60 e2 39 c0 83 c4 14 5b c3 90 8d b4 26 00 00 00=20
 <0>Kernel panic: Aiee, killing interrupt handler!               =20
In interrupt handler - not syncing               =20

It was in "init=3D/bin/bash" and was supposed to be syncing his RAID5
arrays (3 of them) when he decided to eat it.

Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                              =20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=3Dpack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10)=
;'


--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JDYPPvY/pfyW1AURAp5BAJ9s/woM8Frw9JC6ppUgTfI70t6AhwCeNBV/
yRh/qQyLsleIeg+us2SEgIk=
=B0Nu
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
