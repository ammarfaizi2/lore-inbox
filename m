Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLNAb0>; Wed, 13 Dec 2000 19:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQLNAbQ>; Wed, 13 Dec 2000 19:31:16 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:61070 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S129511AbQLNAbI>; Wed, 13 Dec 2000 19:31:08 -0500
Date: Wed, 13 Dec 2000 19:00:37 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: test1[12] + sparc + bind 9.1.0b1 == bad things
Message-ID: <20001213190037.Q1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A38077E.EA04B3C7@metabyte.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A38077E.EA04B3C7@metabyte.com>; from zaitcev@metabyte.com on Wed, Dec 13, 2000 at 03:34:22PM -0800
X-Uptime: 6:43pm  up 1 day,  7:25,  6 users,  load average: 0.12, 0.18, 0.13
X-Married: 395 days, 22 hours, 58 minutes, and 16 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Wed, 13 Dec 2000, Pete Zaitcev wrote:

> > Is this the first OOPS it prints out? I don't think so. I am=20
> > very sure it printed out messages from die_if_kernel first and=20
> > we need that initial OOPS to diagnose this bug and fix it.=20
> >=20
> > All the rest of the OOPS messages are useless and won't tell=20
> > us what the real problem is.=20
>=20
> > Later,=20
> > David S. Miller=20

no, you're right.  here's the first oops:

named(465): Oops
TSTATE: 00000000f0f09603 TPC: 000000000043f730 TNPC: 000000000043f734 Y: 0c=
000000
g0: 70029eb470029ea0 g1: 000000000000003d g2: 0000000000000002 g3: 00000000=
00000000
g4: fffff80000000000 g5: 0000000000000004 g6: fffff8001318c000 g7: 00000000=
0000003d
o0: 000000000068dd00 o1: 0000000000000001 o2: 0000000000000000 o3: 00000000=
00000071
o4: 0000000000000000 o5: 0000000000000000 sp: fffff8001318ed91 ret_pc: 0000=
00000042d5c0
l0: 0000000000000000 l1: 0000000070188270 l2: fffff8001398b8f0 l3: 00000000=
005b4400
l4: 000000000068fc00 l5: 00000000005b45c0 l6: 000000000000000f l7: 00000000=
00000000
i0: 0000000000000000 i1: fffff80010528908 i2: 0000000000000001 i3: 00000000=
00000001
i4: 0000000000000000 i5: 0000000000000003 i6: fffff8001318ee51 i7: 00000000=
004b2878
Caller[00000000004b2878]
Caller[00000000004b2b3c]
Caller[00000000004e205c]
Caller[00000000004ef3d8]
Caller[00000000004e3e5c]
Caller[000000000041b154]
Caller[0000000000408874]
Caller[000000000042d5c0]
Caller[000000000042da28]
Caller[00000000004100b4]
Caller[000000007005ccd4]
Instruction DUMP: a4063ff0  d85ca008  f05e0000 <d05b0000> 900f4008  80a2200=
0  0247fff8  80a60019  02f6ffcc=20
Aiee, killing interrupt handler
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 00000000000005c9
tsk->{mm,active_mm}->pgd =3D fffff80013789000

=2E.and here's its ksymoops output:

ksymoops 2.3.5 on sparc64 2.4.0-test12-1.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (default)

named(465): Oops
TSTATE: 00000000f0f09603 TPC: 000000000043f730 TNPC: 000000000043f734 Y:0c0=
00000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 70029eb470029ea0 g1: 000000000000003d g2: 0000000000000002 g3: 00000000=
00000000
g4: fffff80000000000 g5: 0000000000000004 g6: fffff8001318c000 g7: 00000000=
0000003d
o0: 000000000068dd00 o1: 0000000000000001 o2: 0000000000000000 o3: 00000000=
00000071
o4: 0000000000000000 o5: 0000000000000000 sp: fffff8001318ed91 ret_pc: 0000=
00000042d5c0
l0: 0000000000000000 l1: 0000000070188270 l2: fffff8001398b8f0 l3: 00000000=
005b4400
l4: 000000000068fc00 l5: 00000000005b45c0 l6: 000000000000000f l7: 00000000=
00000000
i0: 0000000000000000 i1: fffff80010528908 i2: 0000000000000001 i3: 00000000=
00000001
i4: 0000000000000000 i5: 0000000000000003 i6: fffff8001318ee51 i7: 00000000=
004b2878
Caller[00000000004b2878]
Caller[00000000004b2b3c]
Caller[00000000004e205c]
Caller[00000000004ef3d8]
Caller[00000000004e3e5c]
Caller[000000000041b154]
Caller[0000000000408874]
Caller[000000000042d5c0]
Caller[000000000042da28]
Caller[00000000004100b4]
Caller[000000007005ccd4]
Instruction DUMP: a4063ff0  d85ca008  f05e0000 <d05b0000> 900f4008 80a22000=
  0247fff8  80a60019  02f6ffcc=20

>>PC;  0043f730 <__wake_up+110/220>   <=3D=3D=3D=3D=3D
>>O7;  0042d5c0 <cmsg32_recvmsg_fixup+80/120>
>>I7;  004b2878 <end_buffer_io_sync+58/80>
Trace; 004b2878 <end_buffer_io_sync+58/80>
Trace; 004b2b3c <end_that_request_first+5c/e0>
Trace; 004e205c <ide_end_request+1c/80>
Trace; 004ef3d8 <ide_dma_intr+78/c0>
Trace; 004e3e5c <ide_intr+13c/1a0>
Trace; 0041b154 <handler_irq+114/1c0>
Trace; 00408874 <tl0_irq3+14/40>
Trace; 0042d5c0 <cmsg32_recvmsg_fixup+80/120>
Trace; 0042da28 <sys32_recvmsg+1e8/2e0>
Trace; 004100b4 <linux_sparc_syscall32+34/40>
Trace; 7005ccd4 <END_OF_CODE+6f9ab454/????>
Code;  0043f724 <__wake_up+104/220>
0000000000000000 <_PC>:
Code;  0043f724 <__wake_up+104/220>
   0:   a4 06 3f f0       add  %i0, -16, %l2
Code;  0043f728 <__wake_up+108/220>
   4:   d8 5c a0 08       unknown
Code;  0043f72c <__wake_up+10c/220>
   8:   f0 5e 00 00       unknown
Code;  0043f730 <__wake_up+110/220>   <=3D=3D=3D=3D=3D
   c:   d0 5b 00 00       unknown   <=3D=3D=3D=3D=3D
Code;  0043f734 <__wake_up+114/220>
  10:   90 0f 40 08       and  %i5, %o0, %o0
Code;  0043f738 <__wake_up+118/220>
  14:   80 a2 20 00       cmp  %o0, 0
Code;  0043f73c <__wake_up+11c/220>
  18:   02 47 ff f8       unknown
Code;  0043f740 <__wake_up+120/220>
  1c:   80 a6 00 19       cmp  %i0, %i1
Code;  0043f744 <__wake_up+124/220>
  20:   02 f6 ff cc       unknown

Aiee, killing interrupt handler
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 00000000000005c9
tsk->{mm,active_mm}->pgd =3D fffff80013789000

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OA2lH/Abp5AIJzYRAqcPAJ45AmJhZI0us8v3I2gzQ3pBMcDSeQCaAj0k
eGOrW3kPnnWQOmNJ4bApBEg=
=dysH
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
