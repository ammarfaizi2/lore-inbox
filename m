Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSHGQiz>; Wed, 7 Aug 2002 12:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSHGQiz>; Wed, 7 Aug 2002 12:38:55 -0400
Received: from [211.20.30.100] ([211.20.30.100]:40099 "EHLO rinse.wov.idv.tw")
	by vger.kernel.org with ESMTP id <S318704AbSHGQiy>;
	Wed, 7 Aug 2002 12:38:54 -0400
Date: Thu, 08 Aug 2002 00:42:17 +0800
From: =?BIG5?B?qMy6v7/f?= <imacat@mail.imacat.idv.tw>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: conflicting types for `xquad_portio' with CONFIG_MULTIQUAD
Message-Id: <20020808004206.EED0.IMACAT@mail.imacat.idv.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="===[PGP/MIME_RFC2015]===3D514DDE.7F3A==="; protocol="application/pgp-signature"; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.05.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===[PGP/MIME_RFC2015]===3D514DDE.7F3A===
Content-Type: text/plain; charset="BIG5"
Content-Transfer-Encoding: 8bit

[1.] conflicting types for `xquad_portio' with CONFIG_MULTIQUAD
[2.] I tried to compile with CONFIG_MULTIQUAD, but it kept saying:

imacat@cotton /tmp/linux-2.4.19 % make install
bsetup.s: Assembler messages:
bsetup.s:1431: Warning: indirect lcall without `*'
misc.c:128: conflicting types for `xquad_portio'
/tmp/linux-2.4.19/include/asm/io.h:324: previous declaration of `xquad_portio'
make[2]: *** [misc.o] Error 1
make[1]: *** [compressed/bvmlinux] Error 2
make: *** [install] Error 2
imacat@cotton /tmp/linux-2.4.19 %

    I have examined the misc.c and io.h.  There are indeed 2 conflict
settings on xquad_portio at the specified lines when compiled with
CONFIG_MULTIQUAD, and misc.c includes io.h.  It should not be working at
all.  I wonder how other people could compile with CONFIG_MULTIQUAD.

    I was compiling by the clean default options in "make menuconfig",
with only the CONFIG_MULTIQUAD turned on.

[3.] CONFIG_MULTIQUAD, xquad_portio, misc.c, io.h
[4.] 2.4.19
[5.] 

imacat@cotton /tmp/linux-2.4.19 % make install
bsetup.s: Assembler messages:
bsetup.s:1431: Warning: indirect lcall without `*'
misc.c:128: conflicting types for `xquad_portio'
/tmp/linux-2.4.19/include/asm/io.h:324: previous declaration of `xquad_portio'
make[2]: *** [misc.o] Error 1
make[1]: *** [compressed/bvmlinux] Error 2
make: *** [install] Error 2
imacat@cotton /tmp/linux-2.4.19 %

[6.] N/A
[7.] Environment
[7.1.] Red Hat 7.3, gcc 3.1, glibc 2.2.5
[7.2.] AMD 1800+
[7.3.] none
[X.] none


--
Best regards,
imacat ^_*'
imacat@mail.imacat.idv.tw
PGP Key: http://www.imacat.idv.tw/me/pgpkey.txt

<<Woman's Voice>> News: http://www.wov.idv.tw/
Tavern IMACAT's: http://www.imacat.idv.tw/
TLUG List Manager: http://www.linux.org.tw/mailman/listinfo/tlug

--===[PGP/MIME_RFC2015]===3D514DDE.7F3A===
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6-2 (MingW32)
Comment: For info see http://www.gnupg.org

iD8DBQA9UU3di9gubzC5S1wRAg68AKCsHbMXotPilGEtajQfcTr8BTzemwCeJOXk
tq+P4rY8jukeR/0CFgjCvVc=
=79lv
-----END PGP SIGNATURE-----

--===[PGP/MIME_RFC2015]===3D514DDE.7F3A===--

