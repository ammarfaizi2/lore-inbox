Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVBGTQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVBGTQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVBGTQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:16:09 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28936 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261253AbVBGTOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:14:48 -0500
Message-Id: <200502071914.j17JEbjQ018534@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Filesystem linking protections 
In-Reply-To: Your message of "Mon, 07 Feb 2005 19:57:06 +0100."
             <1107802626.3754.224.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <1107802626.3754.224.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107803677_3249P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 14:14:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107803677_3249P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 19:57:06 +0100, Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= said:

> This patch adds two checks to do_follow_link() and sys_link(), for
> prevent users to follow (untrusted) symlinks owned by other users in
> world-writable +t directories (i.e. /tmp), unless the owner of the
> symlink is the owner of the directory, users will also not be able to
> hardlink to files they do not own.

This should be done using the LSM framework.  That's what it's *THERE* for.
I've previously posted an LSM that does these checks (and a few others), it
should be in the archives.

--==_Exmh_1107803677_3249P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFCB74dcC3lWbTT17ARAr+nAJ9E0O7IoLuoe2c3pXG9RyU2FUQlVACY7c5+
//quHWX3B+uMdx4O2ibqgg==
=yb6i
-----END PGP SIGNATURE-----

--==_Exmh_1107803677_3249P--
