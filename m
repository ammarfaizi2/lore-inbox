Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUBDDUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 22:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUBDDUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 22:20:37 -0500
Received: from h80ad267b.async.vt.edu ([128.173.38.123]:11136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266208AbUBDDUf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 22:20:35 -0500
Message-Id: <200402040320.i143KCaD005184@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: the grugq <grugq@hcunix.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch 
In-Reply-To: Your message of "Wed, 04 Feb 2004 00:33:37 GMT."
             <40203DE1.3000302@hcunix.net> 
From: Valdis.Kletnieks@vt.edu
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz>
            <40203DE1.3000302@hcunix.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1797857396P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Feb 2004 22:20:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1797857396P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Feb 2004 00:33:37 GMT, the grugq said:

> All that said, the user's content is something that the user could be =

> considered responsible for erasing themselves. The meta-data is the par=
t =

> of the file which they dont' have access to, so having privacy =


Actually, I have encountered file systems where two successive
write() calls from userspace to the same offset in the file wouldn't
end up in the same physical location on the disk (AIX's JFS with compress=
ion).
It would LZ compress each 4K block, and then find a contiguous set of
512-byte sectors to write it.  So one write might compress down to 6 sect=
ors
and be written in one place, the next time it doesn't compress as well
and takes 7 - so it ends up elsewhere because the previous hole was
exactly 6 - and if you try to zero it by writing a block of zeros, that
would compress down to 1 sector and fail to overwrite the others...

If we ever do a filesystem with compression, we'll have the same issue.



--==_Exmh_1797857396P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIGTscC3lWbTT17ARAkEAAJ4y5bSp1XQnJYRr49MrQw0XXXhtXACeMz/m
NHZpURNKKCi7lQd/IZ67ZSk=
=NUVs
-----END PGP SIGNATURE-----

--==_Exmh_1797857396P--
