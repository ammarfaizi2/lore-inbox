Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264003AbTJ1Pkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTJ1Pkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:40:41 -0500
Received: from h80ad275b.async.vt.edu ([128.173.39.91]:10899 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264003AbTJ1Pkh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:40:37 -0500
Message-Id: <200310281539.h9SFdixF024951@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup 
In-Reply-To: Your message of "Tue, 28 Oct 2003 09:39:53 EST."
             <Pine.LNX.4.53.0310280936550.20004@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <3F9E707B.7030609@freemail.hu>
            <Pine.LNX.4.53.0310280936550.20004@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1037933818P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Oct 2003 10:39:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1037933818P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Oct 2003 09:39:53 EST, "Richard B. Johnson" said:
> On Tue, 28 Oct 2003, Boszormenyi Zoltan wrote:
> [SNIPPED...]
> 
> > -rw-rw-r--    1 zozo     zozo      1090912 okt 27 22:54 interface.c
>                                      ^^^^^^^
> Guess you use `vim` to edit ...eh?
> 
> Linux does have a good linker, you know. You don't need to put
> everything in one file!

On the flip side, if there's a lot of routines all declared 'static' so they are
only visible to that .c file, it's less than simple to split them out and
tell the *rest* of the projects that 'routines in interface/*.c are visible
to each other, but not to C code in database/*.c'.

The Linux kernel has the same issues:

% find . -name '*.[ch]' | xargs grep acpi_bus_unregister_driver

referenced only in drivers/acpi and one include file - but pollutes the global
linkage namespace all the same.

--==_Exmh_1037933818P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/no2/cC3lWbTT17ARAv+EAJ9VCwUc31A7Oi2HBDXFpuzCiNJkKACfTxWJ
BxodGaG+WEma/ukbA4/FCYE=
=FVqn
-----END PGP SIGNATURE-----

--==_Exmh_1037933818P--
