Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVIGKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVIGKME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVIGKME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:12:04 -0400
Received: from h80ad25ab.async.vt.edu ([128.173.37.171]:16094 "EHLO
	h80ad25ab.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751106AbVIGKMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:12:01 -0400
Message-Id: <200509071011.j87ABcWT018168@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, "Budde, Marco" <budde@telos.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++ 
In-Reply-To: Your message of "Wed, 07 Sep 2005 11:21:42 +0200."
             <Pine.OSF.4.05.10509071055180.21532-100000@da410.phys.au.dk> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.OSF.4.05.10509071055180.21532-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126087897_3088P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 06:11:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126087897_3088P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Sep 2005 11:21:42 +0200, Esben Nielsen said:

> I use a RTOS written in plain C but where you can easily use C++ in kernel
> space (there is no user-space :-). We use gcc by the way.

This isn't RTOS, in case you haven't noticed. ;)

> It has been done for Linux as well 
> (http://netlab.ru.is/pronto/pronto_code.shtml). Why can't this kind of
> stuff be merged into the kernel? Why is there no efford to do so??

Quoting http://netlab.ru.is/exception/LinuxCXX.shtml:

"The code is installed by applying a patch to the Linux kernel and enables the
full use of C++ using the GNU g++ compiler. Programmers that have used C++ in
Linux kernel modules have primarily been using classes and virtual functions,
but not global constructors. dynamic type checking and exceptions. Using even
this small part of C++ requires each programmer to write some supporting
routines. Using the rest of C++ includes porting the C++ ABI that accompanies
GNU g++ to the Linux kernel, and to enable global constructors and destructors."

So let's see - no constructors, no type checking, no exceptions, and using
virtual functions requires the programmer to write the glue code that
programmers want to use C++ to *avoid* writing.  Sounds like "We stripped out
all the reasons programmers want to use C++ just so we can say we use C++ in
the kernel".

So, other than wank value, what *actual* advantages are there to using this
limited subset of C++ in the kernel?

--==_Exmh_1126087897_3088P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHrzZcC3lWbTT17ARAlXXAJ9X35XWSvOw+EeeqFbERH9MDupzUACgzwOI
gLCy+WYI/xHBY9CPEXuZKrk=
=oY1N
-----END PGP SIGNATURE-----

--==_Exmh_1126087897_3088P--
