Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUACEP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 23:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUACEP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 23:15:27 -0500
Received: from h80ad244b.async.vt.edu ([128.173.36.75]:27842 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262569AbUACEPZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 23:15:25 -0500
Message-Id: <200401030415.i034FJoc006230@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tobias Diedrich <ranma@gmx.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again) 
In-Reply-To: Your message of "Sat, 03 Jan 2004 04:33:28 +0100."
             <20040103033327.GA413@melchior.yamamaya.is-a-geek.org> 
From: Valdis.Kletnieks@vt.edu
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu> <200401022200.22917.ornati@lycos.it>
            <20040103033327.GA413@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_207414218P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Jan 2004 23:15:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_207414218P
Content-Type: text/plain; charset=us-ascii

On Sat, 03 Jan 2004 04:33:28 +0100, Tobias Diedrich <ranma@gmx.at>  said:

> Very interesting tidbit:
> 
> with 2.6.1-rc1 and "dd if=/dev/hda of=/dev/null" I get stable 28 MB/s,
> but with "cat < /dev/hda > /dev/null" I get 48 MB/s according to "vmstat
> 5".

'cat' is probably doing a stat() on stdout and seeing it's connected to /dev/null
and not even bothering to do the write() call.  I've seen similar behavior in other
GNU utilities.  

--==_Exmh_207414218P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/9kHWcC3lWbTT17ARArAYAJ92e+41lp0cx8kWzYMaYTHBFgHOrQCfbNWJ
ssT1/lnx9GZAgzBZgKZeTxM=
=NkGd
-----END PGP SIGNATURE-----

--==_Exmh_207414218P--
