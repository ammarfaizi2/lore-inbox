Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUAJONl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUAJONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:13:41 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:21918 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S265169AbUAJONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:13:39 -0500
Date: Sat, 10 Jan 2004 15:13:37 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2. ELF loader mystery
Message-Id: <20040110151337.4de136ed@argon.inf.tu-dresden.de>
In-Reply-To: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>
References: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__10_Jan_2004_15_13_37_+0100_8ddft2/LPoZ3kvU4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__10_Jan_2004_15_13_37_+0100_8ddft2/LPoZ3kvU4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2004 14:53:29 +0100 Udo A. Steinberg (UAS) wrote:

UAS> results in the following memory map after startup:
UAS> 
UAS> 00001000-000a8000 rwxp 00000000 03:07 62988      /tmp/prog
UAS> 000ba000-000bf000 rwxp 000a7000 03:07 62988      /tmp/prog
UAS> bffff000-c0000000 rwxp 00000000 00:00 0

To illustrate my point, below is what the memory map for the exact same
binary looks like on 2.6. The VMA in question is the one between
0xa8000 and 0xba000, which 2.2. kernels don't zero-allocate.

00001000-000a8000 rwxp 00000000 03:07 62988      /tmp/prog
000a8000-000ba000 rwxp 00000000 00:00 0 
000ba000-000bf000 rwxp 000a7000 03:07 62988      /tmp/prog
bffff000-c0000000 rwxp 00000000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

-Udo.

--Signature=_Sat__10_Jan_2004_15_13_37_+0100_8ddft2/LPoZ3kvU4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAAiSnhRzXSM7nSkRApx3AJ45tDCvXY+jC6bvdO0W4sIN9IkDOACfeEfv
GnMjpiS2JVdwp3cs+Grza6I=
=p/oC
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Jan_2004_15_13_37_+0100_8ddft2/LPoZ3kvU4--
