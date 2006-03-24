Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423141AbWCXFbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423141AbWCXFbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423142AbWCXFbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:31:05 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:15825 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423141AbWCXFbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:31:04 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Linus Torvalds <torvalds@osdl.org>
Subject: 92c05fc1a32e5ccef5e0e8201f32dcdab041524c breaks x86_64 compile.
Date: Fri, 24 Mar 2006 15:29:23 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4829751.JhoS9OZdHL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603241529.28811.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4829751.JhoS9OZdHL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

It looks to me like the above commit from Andi causes a compilation failure=
 on=20
x86_64, because it makes pci_mmcfg_init non static:

arch/x86_64/pci/mmconfig.c:152: error: conflicting types for =E2=80=98pci_m=
mcfg_init=E2=80=99
arch/i386/pci/pci.h:85: error: previous declaration of =E2=80=98pci_mmcfg_i=
nit=E2=80=99 was=20
here
make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
make: *** [arch/x86_64/pci] Error 2

Regards,

Nigel

--nextPart4829751.JhoS9OZdHL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEI4O4N0y+n1M3mo0RAtJuAKD3DkLLxQOReylfPKhmn9XTzQ+m2wCgqZIK
S7HTPDoNjlq8UtfZ+W1FZXQ=
=oAXh
-----END PGP SIGNATURE-----

--nextPart4829751.JhoS9OZdHL--
