Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbULQV5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbULQV5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbULQV5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:57:03 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:25223 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262174AbULQVuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:50:02 -0500
Message-Id: <200412172149.iBHLnsEP013332@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with workaround... 
In-Reply-To: Your message of "Fri, 17 Dec 2004 15:04:21 EST."
             <1103313861.12664.71.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu> <1103300362.12664.53.camel@localhost.localdomain> <1103303011.12664.58.camel@localhost.localdomain> <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
            <1103313861.12664.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_70909586P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Dec 2004 16:49:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_70909586P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Dec 2004 15:04:21 EST, Steven Rostedt said:

> Nope! I have the 6629. Actually, the patch you have for NV solved the
> pgd_offset problem.

Glad to hear it, I'm just the messenger on that one (I forget which lkml
denizen actually wrote/posted that one).

>                       But I'm amazed that you didn't get into the
> may_sleep calls.

I'm actually not *that* surprised - my test base consists entirely of one Dell
Latitude C840 laptop with a GeForce4 440 Go card, so there's no SMP issues or
similar, and I don't do heavy 3D or anything unless xscreensaver decides to use
a random OpenGL display hack. Most likely, your hardware and/or CONFIG_* setup
is getting it into code paths that never get hit on my system. And the
might_sleep() is almost certainly on one of those paths.

(For the record, I *did* see a few might_sleep hits on 2.6.10-rc2-mm4-V0.7.31-15,
but they only hit sendmail, gpg, bash, and stuff like that, never an X-based program.)

--==_Exmh_70909586P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBw1SCcC3lWbTT17ARAqLuAKCd6ihq4pVjnUzX6q5Tq/4ZXNuOhQCfR8LE
yG3wr9wGzGgawV2GhcSOkBk=
=dVpm
-----END PGP SIGNATURE-----

--==_Exmh_70909586P--
