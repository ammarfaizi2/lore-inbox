Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVGJDyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGJDyY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 23:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVGJDyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 23:54:23 -0400
Received: from h80ad2588.async.vt.edu ([128.173.37.136]:60058 "EHLO
	h80ad2588.async.vt.edu") by vger.kernel.org with ESMTP
	id S261387AbVGJDyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 23:54:22 -0400
Message-Id: <200507100353.j6A3rtU9020857@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "liyu@WAN" <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: The question come again. 
In-Reply-To: Your message of "Sun, 10 Jul 2005 11:28:20 +0800."
             <42D095D4.3020907@ccoss.com.cn> 
From: Valdis.Kletnieks@vt.edu
References: <42D095D4.3020907@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1120967631_8886P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Jul 2005 23:53:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1120967631_8886P
Content-Type: text/plain; charset=us-ascii

On Sun, 10 Jul 2005 11:28:20 +0800, "liyu@WAN" said:

>     But I found it may call __you_cannot_kmalloc_that_much(). but I can 
> not get where is
> defined.

Note that you can only reach it if you have a *compile-time constant* of
over 32M or so in size.  If it's smaller, it will catch the appropriate
if/then from kmalloc_sizes.h (and all the others removed by the optimizer).

And since there *isn't* a definition, you'll get a complaint when you
try to link vmlinux - and the complaint will tell you where it's referenced.



--==_Exmh_1120967631_8886P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC0JvPcC3lWbTT17ARAu97AKDwSmQbpHHwtOLWIwWARLVuQg+d9gCg4RPt
6g0KWyTpX2oOAO4EO0h0Qfc=
=bjPt
-----END PGP SIGNATURE-----

--==_Exmh_1120967631_8886P--
