Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWDEVxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWDEVxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWDEVxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:53:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43424 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932085AbWDEVxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:53:03 -0400
Message-Id: <200604052152.k35LqtQ0032100@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules_install must not remove existing modules 
In-Reply-To: Your message of "Wed, 05 Apr 2006 23:33:50 +0200."
             <200604052333.51085.agruen@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <200604052333.51085.agruen@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1144273939_4315P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Apr 2006 17:52:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1144273939_4315P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Apr 2006 23:33:50 +0200, Andreas Gruenbacher said:
> When installing external modules with `make modules_install', the
> first thing that happens is a rm -rf of the target directory. This
> works only once, and breaks when installing more than one (set of)
> external module(s).

Can this be re-worked to ensure that it clears the target directory
the *first* time?  It would suck mightily if a previous build of 2.6.17-rc2
left a net_foo.ko lying around to get insmod'ed by accident (consider the case
of CONFIG_NETFOO=m getting changed to y or n, and other possible horkage.
Module versioning will catch some, but not all, of this crap....)

--==_Exmh_1144273939_4315P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFENDwTcC3lWbTT17ARAh+ZAKDAzjTYAq1biz01x7BeN6Zu43xeuACfbnxC
TBV3g/Srvi1sl7NmDaNglEQ=
=jKov
-----END PGP SIGNATURE-----

--==_Exmh_1144273939_4315P--
