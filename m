Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVEJPLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVEJPLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEJPLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:11:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51461 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261651AbVEJPLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:11:42 -0400
Message-Id: <200505101511.j4AFBYcd010704@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: KC <kcc1967@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.x driver compiler options 
In-Reply-To: Your message of "Tue, 10 May 2005 16:08:30 +0800."
             <5eb4b0650505100108179ba1b6@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <5eb4b0650505100108179ba1b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115737893_8169P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 May 2005 11:11:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115737893_8169P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 May 2005 16:08:30 +0800, KC said:

> Instead of using Linux kconfig build system, can someone tell me
> what's the compiler options used to build a device driver (.ko file) ?

There's plenty of documentation on how to use 'make' to build an
out-of-tree .ko.

> Or, how can I integrate kconfig with GNU tool chain (automake, autoconf ...)

First, describe the semantics.  How the <bleep> is that ever "supposed to work"?
automangle and friends are designed so you can configure userspace programs to
run no matter what oddities the underlying system has.  Kconfig is for actually
describing the underlying system.

At *best*, all you could do is use the .config variables to answer some of
the "is XYZ present?" tests done in ./configure - but even *that* is Pigheaded
And Wrong, because it will get it wrong if you're pulling hints from a kernel
tree that doesn't match the running kernel, or if it's a new-ish feature that
requires userspace library support that isn't installed on the system...

--==_Exmh_1115737893_8169P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCgM8lcC3lWbTT17ARAsL0AJ0XWWP7kDv0enT2/lht895oXYxEMQCePOXe
swwsWBwqWXR4DWvhkBslz8c=
=AKum
-----END PGP SIGNATURE-----

--==_Exmh_1115737893_8169P--
