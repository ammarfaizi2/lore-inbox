Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUALRZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUALRZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:25:59 -0500
Received: from h80ad25ab.async.vt.edu ([128.173.37.171]:51330 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265535AbUALRZ1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:25:27 -0500
Message-Id: <200401121725.i0CHPJtl023522@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dan Egli <dan@eglifamily.dnsalias.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x breaks some Berkeley/Sleepycat DB functionality 
In-Reply-To: Your message of "Mon, 12 Jan 2004 10:16:12 MST."
             <4002D65C.1010505@eglifamily.dnsalias.net> 
From: Valdis.Kletnieks@vt.edu
References: <4002D65C.1010505@eglifamily.dnsalias.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-440933004P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jan 2004 12:25:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-440933004P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Jan 2004 10:16:12 MST, Dan Egli <dan@eglifamily.dnsalias.net>  said:

> I run a PGP Public key server on this machine and under 2.4.x it's
> "smooth as silk". But if I boot under 2.6.x, it's gaurenteed failure. If
> I try to build a database using the build command (this is an sks
> server, so it's sks build or sks fastbuild) I IMMEDIATELY get  Bdb
> error. But the exact same command with the exact same libraries and
> input files under 2.4.20 works without a hitch.
> 
> Anyone got any ideas? Anything else I can provide to assist in debugging?

Off the top of my head, O_DIRECT horkage?  I believe that 2.6 has more
stringent buffer alignment requirements.  A quick 'strace' would probably show
if that's the problem.


--==_Exmh_-440933004P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAAth+cC3lWbTT17ARAoijAKCKlQMvni2JlTgw/gfXEQK73zK7CACZAZQ+
cUd1j8gnCWscFnhmOlpEB8M=
=+VbI
-----END PGP SIGNATURE-----

--==_Exmh_-440933004P--
