Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272157AbTHEMX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272681AbTHEMX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:23:58 -0400
Received: from [24.241.190.29] ([24.241.190.29]:12947 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S272157AbTHEMX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:23:56 -0400
Date: Tue, 5 Aug 2003 08:23:54 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: FINALLY caught a panic
Message-ID: <20030805122354.GL13456@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0+35XlDF45POFHfm"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0+35XlDF45POFHfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I've got a machine which has been dying repeatedly with nothing loged to
the serial console we could see.  The problem was the console would kick
you off if idle for too long.  I managed to keep one it from
disconnecting for quite some time and finally got a panic.  I caught
this:

Unable to handle kernel paging request at virtual address 8011c560
 printing eip:
8011c560
*pde =3D 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<8011c560>]    Not tainted
EFLAGS: 00010286
eax: 8011c560   ebx: c037f754   ecx: 00000040   edx: c0357980
esi: 00000040   edi: c037f740   ebp: c037ef40   esp: c1e19f28
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Dc1e19000)
Stack: c011c47d 00000001 c0358180 00000001 fffffffe 00000040 c011c1ff c0358=
180=20
       c037ef40 c0351800 00000000 c1e19f74 00000046 c0108bdb c0105400 c1e18=
000=20
       c0105400 00000040 c02f5b44 00000000 c010ae78 c0105400 c1e18000 c1e18=
000=20
Call Trace: [<c011c47d>] [<c011c1ff>] [<c0108bdb>] [<c0105400>] [<c0105400>=
]=20
   [<c010ae78>] [<c0105400>] [<c0105400>] [<c010542c>] [<c01054a2>] [<c0117=
e7f>]=20
   [<c0117d8e>]=20

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Can someone please tell me what this means or how to figure it out?  The
machine is offline for the next 12 hours unfortunately due to lack of
remote help.  I do have similar machines with the same kernel/hardware
if I need to run any commands against this output.  I don't have access
to any specific files on the machine though.

Thanks,
  Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--0+35XlDF45POFHfm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/L6Ha8+1vMONE2jsRAhhkAKC9Bj7WAPF250eHWg2c1JZFW3lWbgCfbFfJ
JkF27yDxczbG+5hmQiX28AM=
=6rfq
-----END PGP SIGNATURE-----

--0+35XlDF45POFHfm--
