Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265208AbUFAUWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbUFAUWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUFAUWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:22:31 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34962 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265213AbUFAUWR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:22:17 -0400
Message-Id: <200406012022.i51KMFEB002660@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Tue, 01 Jun 2004 22:14:26 +0200."
             <1086120865.2278.27.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net> <1086114982.2278.5.camel@localhost.localdomain> <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu> <1086119611.2278.16.camel@localhost.localdomain> <200406012000.i51K0vor019011@turing-police.cc.vt.edu>
            <1086120865.2278.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_665926786P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 16:22:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_665926786P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 22:14:26 +0200, FabF said:

> Boring....You can't have X root layer swapped to disk as it's often used
> ! Some quick lsof | grep "libX" gives all frontal applications 'swapping
> sensible' .fuser can do 'user resource reverse'.Kernel _can_ 'appl.
> resource reverse' as well.

The point you're missing is that if you use a rule such as "everything using
libX* isn't swappable", then the X *server* is suddenly the prime candidate for
swapping out (as it's quite likely the biggest user of memory not using libX*).
(Anybody who ever had the OOM killer whomp their X server to free up space
fast when the *real* problem was a cluster of 6 or 8 "large but still smaller
than the X server" processes knows exactly what I mean... ;)

> PS: I'm not talking about inactive desktop box.Such box has to be rl 3
> and is not meant to be user (geek) relevant :)

So you're saying that I should have kicked my laptop down to runlevel 3 just
because I went across the hall to the machine room to help get a few servers
into racks?  Or every time I go into a meeting, or get stuck on a longish phone
call?

Also, be *very* careful equating "user" with "geek" - at least some of us are
trying to produce systems that suit the needs of non-geek users....


--==_Exmh_665926786P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvOV2cC3lWbTT17ARAsvpAJ0eZGS52FYHFfPMtS8iEaC9jVxgMACeMiUb
4FlkgAiiB6YQcTHidOxi1TU=
=4mf0
-----END PGP SIGNATURE-----

--==_Exmh_665926786P--
