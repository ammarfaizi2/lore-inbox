Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUJPQvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUJPQvK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUJPQvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:51:09 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:32393 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S268791AbUJPQvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:51:02 -0400
Date: Sat, 16 Oct 2004 18:50:58 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: XFS oops on loading the module
Message-ID: <20041016165058.GB32324@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-cirrus i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just tried to mount an XFS filesystem on this AMD K6 machine,
booted with the 2.6.8 kernel for FAI
(http://www.informatik.uni/koeln.de/fai) (let me know if you need
any information about it), and modprobe segfaults with a kernel bug.
Have you seen this before? Thanks!

sh-2.05b# modprobe xfs
Segmentation fault
------------[ cut here ]------------
kernel BUG at kernel/module.c:264!
invalid operand: 0000 [#1]
SMP=20
Modules linked in: ext3 jbd mbcache sr_mod sd_mod scsi_mod ide_generic usbm=
ouse usbhid ide_cd cdrom usbkbd floppy rtc via82cxxx slc90e66 sis5513 siima=
ge serverworks rz1000 piix pdc202xx_old pdc202xx_new hpt366 ide_disk hpt34x=
 cs5530 cmd64x amd74xx alim15x3 aec62xx ide_core uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c012bcf6>]    Not tainted
EFLAGS: 00010202   (2.6.8-fai)=20
EIP is at percpu_modalloc+0xe/0xf8
eax: 0000004b   ebx: e09f9400   ecx: e09f940c   edx: 0000000f
esi: e09f84c4   edi: 00000258   ebp: e09fa9c8   esp: d9963f0c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1272, threadinfo=3Dd9962000 task=3Ddfb50650)
Stack: e09f9400 e09f84c4 00000258 e09fa9c8 c012d8be e098f000 c012d8ed 00000=
148=20
       00000020 40157000 080509b8 c031f504 d9962000 c416c0a0 00000044 00000=
060=20
       df0ad4e0 00000000 00000000 e09f9400 0000000f 00000000 00000000 00000=
000=20
Call Trace:
 [<c012d8be>] load_module+0x3c6/0x904
 [<c012d8ed>] load_module+0x3f5/0x904
 [<c012de59>] sys_init_module+0x5d/0x200
 [<c0105d5f>] syscall_call+0x7/0xb
Code: 0f 0b 08 01 6f a5 2b c0 89 f6 bd a0 10 40 c0 31 f6 a1 2c 64=20

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
because light travels faster than sound,
some people appear to be intelligent,
until you hear them speak.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcVFyIgvIgzMMSnURAoWNAKDOzPqdsilHlDOlTtjLetUaNXzQzQCgrc39
AHxXrnfYyDAo6mUoOA3mj3M=
=iUHR
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
