Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYXl4>; Thu, 25 Jan 2001 18:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRAYXlq>; Thu, 25 Jan 2001 18:41:46 -0500
Received: from [63.148.55.4] ([63.148.55.4]:1529 "EHLO ninigret.metatel.office")
	by vger.kernel.org with ESMTP id <S129051AbRAYXle>;
	Thu, 25 Jan 2001 18:41:34 -0500
Message-Id: <200101252341.SAA01008@ninigret.metatel.office>
From: Rafal Boni <rafal.boni@eDial.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.2.19pre6/7: why can't I dump core?
X-Mailer: NMH 1.0 / EXMH 2.1.1
Date: Thu, 25 Jan 2001 18:41:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Folks:

Maybe I'm missing something, but nothing seems to be able to dump core
on my 2.2.19pre6 box.  It looks like a lot of things look for 'current->
dumpable == 1' (actually, != 1) but I don't see the dumpable parameter
being set to 1 anywhere.  Moreover, it does get set to non-zero in a
few places, but then gets reset if the binary is readable (not sure if
I read that code correctly)??

I've done a quick inspection of pre7 patch set and noticed about the
same thing.  Is this an oversight, did someone intentionally turn off
core dumping until some other widget is incorporated into the patches,
or none of the above (a conspiracy, maybe? 8-).

[BTW, I'd appreciate it if you CC'ed me on any answers, as I'm not on 
 the list due to high traffic...]

Thanks for any insight,
- --rafal

- ----
Rafal Boni                                               rafal.boni@eDial.com
 PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3 024C
    Need to get a hold of me?  http://800.eDial.com/rafal.boni@eDial.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6cLmsEeBxM8fTAkwRAtFkAKCl0yDb+6kN7xoUAi9JW9mAtIAMPQCfQnvX
3ZOwOmeMPX7kchQL9mXJGtU=
=TSbX
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
