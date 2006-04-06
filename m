Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWDFEYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWDFEYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWDFEYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:24:48 -0400
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:63891 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S932147AbWDFEYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:24:47 -0400
Message-Id: <200604060424.k364OYYV007333@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall 
In-Reply-To: Your message of "Wed, 05 Apr 2006 23:47:24 +0200."
             <200604052147.k35LlOpK010229@wildsau.enemy.org> 
From: Valdis.Kletnieks@vt.edu
References: <200604052147.k35LlOpK010229@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1144297473_2641P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Apr 2006 00:24:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1144297473_2641P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Apr 2006 23:47:24 +0200, Herbert Rosmanith said:

> anyway, the manpage describes how auditd/libaudit works - not how it has been
> implemented/how it communicates with the kernel.
> I want to know how it works "under the hood", not just how to use it.

One thing that's not at all clear from casual reading of the source code
of either the kernel or the userspace, or most of the existing docs...

The audit facility is *very much* an after-the-fact logging - there are a
few places where the code jumps through very odd hoops to deal with the fact
that by the time an actual notification is generated, the entire process that
triggered the event could be *gone*, completely and totally.

--==_Exmh_1144297473_2641P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFENJgBcC3lWbTT17ARAoMKAJ9RYJ4k0erm4OJvGGv8NSqPvbGMOACgxVJ9
B+8yVP5695tejJspgOPYJ/8=
=HEFE
-----END PGP SIGNATURE-----

--==_Exmh_1144297473_2641P--
