Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUATF3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUATF3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:29:21 -0500
Received: from h80ad2483.async.vt.edu ([128.173.36.131]:14720 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265151AbUATF3L (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:29:11 -0500
Message-Id: <200401200529.i0K5T3oe005335@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ kernel module + Makefile 
In-Reply-To: Your message of "Mon, 19 Jan 2004 18:40:18 +0100."
             <400C1682.2090207@samwel.tk> 
From: Valdis.Kletnieks@vt.edu
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk> <Pine.LNX.4.53.0401190839310.6496@chaos>
            <400C1682.2090207@samwel.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1442013846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jan 2004 00:29:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1442013846P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 Jan 2004 18:40:18 +0100, Bart Samwel said:

> Now, let me try to add a bit of nuance to your suggested solution. Try 
> porting 100s of C++ files (yes, it's that large) making heavy use of 
> inheritance etc. to C. Then try to make a bit of C code usable as extern 
> "C" in C++. Extern "C" was actually meant to be able to grok most C 
> code, while C++ wasn't meant to be easily portable to C. So, for any 
> moderately large module that uses any C++ features at all, it's probably 
> easier to make small syntactic changes to the kernel than to port the 
> module to C (which would amount to a full rewrite).

That's one honking big module. Everybody please join me in a sigh of relief
that the culprits didn't think Scheme was a suitable language.

Anybody who thinks that C++ should be anywhere on the kernel side of the kernel/
user interface should understand why the kernel design doesn't even allow the
use of *floating point* without much jumping through hoops. They then should
ponder the political climate that created EXPORT_SYMBOL_GPL, which is
(basically) a "this is OUR kernel and if you don't want to play by our rules,
we intend to make things difficult for you".

The module authors should then ask themselves what they're bringing to the
table that's worth the kernel developers changing the way they do things.
Unless there's a demonstrable reason or advantage to changing, the idea to
support C++ is probably as dead-on-arrival as the heavily lambasted proposal to
have a stable API for modules a while back.


--==_Exmh_1442013846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADLyecC3lWbTT17ARAhRJAKD0K70gcBHHf/0BsP1uBGGfAh5NXgCfThE3
mSwZt4AGCrnjuQF/Iq4oUVo=
=KPZU
-----END PGP SIGNATURE-----

--==_Exmh_1442013846P--
