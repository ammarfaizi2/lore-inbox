Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWEBGly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWEBGly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWEBGly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:41:54 -0400
Received: from h80ad2444.async.vt.edu ([128.173.36.68]:14242 "EHLO
	h80ad2444.async.vt.edu") by vger.kernel.org with ESMTP
	id S932402AbWEBGlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:41:53 -0400
Message-Id: <200605020641.k426fkOJ002057@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Irfan Habib <irfan.habib@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel and Webservices 
In-Reply-To: Your message of "Tue, 02 May 2006 11:13:38 +0500."
             <3420082f0605012313k767c20aage4de6bf8c5e736f@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <3420082f0605011951m43479a98ie56a0a5f62409dd2@mail.gmail.com> <200605020409.k4249EiJ007414@turing-police.cc.vt.edu>
            <3420082f0605012313k767c20aage4de6bf8c5e736f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146552105_2571P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 02:41:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146552105_2571P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 May 2006 11:13:38 +0500, Irfan Habib said:
> If DNS is not available then, I can access system directly via the IP
> address. Is it possible for a kernel level deamon to listen to some
> ports, inorder for inserting things directly into the kernel, via some
> remote machines?

As I said, the lack of DNS is just the *start* of your troubles. Things just
get worse once you start trying to do error handling and other similar issues.
For instance, how do you intend to secure this "insert things directly into
the kernel"?

You *really* want to do this in userspace - if nothing else, it's a lot easier
to develop and debug userspace (when a userspace program you're debugging
crashes, you get a gdb prompt rather than a kernel panic), and it shouldn't be
put in the kernel unless there's no reasonable way to do it in userspace.

This is certainly well into the category of "If you have to ask if it's possible,
you're nowhere near qualified to make it work"...

--==_Exmh_1146552105_2571P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEVv8pcC3lWbTT17ARAiGRAJ9FotAhe/ptxR7CraMk5B7sd/ZYgACfTTJA
Chiec/0cl3lZciicgk59lVo=
=NsaM
-----END PGP SIGNATURE-----

--==_Exmh_1146552105_2571P--
