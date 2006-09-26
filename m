Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWIZSAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWIZSAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWIZSAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:00:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61838 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932240AbWIZSAo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:00:44 -0400
Message-Id: <200609261800.k8QI0a5i027891@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ben Duncan <ben@versaccounting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EIP Errors kernel 2.6.18 .AND hard lockup ...
In-Reply-To: Your message of "Tue, 26 Sep 2006 12:39:49 CDT."
             <451965E5.1080600@versaccounting.com>
From: Valdis.Kletnieks@vt.edu
References: <45194883.3080700@versaccounting.com> <6bffcb0e0609260851q5d97f784i47d43f2076843600@mail.gmail.com>
            <451965E5.1080600@versaccounting.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159293635_3699P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 14:00:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159293635_3699P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Sep 2006 12:39:49 CDT, Ben Duncan said:
> I am not sure why this should got to nVidia (Please, I
> personally know the Head of nVidias' Linux driver development,
> so if it is a nVidia problem, I can help there).

Maybe is, maybe isn't.

> desktop kernel: EIP:    0060:[<c01ba714>]    Tainted: P      VLI
                             proprietary module loaded--^

> To me seems to be a PDFLUSH eip and the nvidia stuff is just
> a by product of loaded modules, no?

The point is that we can't know that the NVidia module hasn't stomped on
some random memory location that happened to corrupt a radix tree.  Note
that this is true even if you've loaded and then unloaded the module - it
may have splatted something before it departed....

Is it a replicatable error, and if so, can you replicate it without loading
the NVidia module?  If you can come up with a traceback that doesn't have
an NVidia tainting in it, we'll be glad to look at it.  Conversely, if you're
able to replicate it with nvidia loaded, but not without, toss it over
the fence to your friend.

--==_Exmh_1159293635_3699P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFGWrDcC3lWbTT17ARAu7fAKDmebRoLnJLMDTY71E7wUV9oLsdUwCbBfjB
BIKgnfpug6r1k5yncN9I4jk=
=9CNQ
-----END PGP SIGNATURE-----

--==_Exmh_1159293635_3699P--
