Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWEPCiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWEPCiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWEPCiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:38:07 -0400
Received: from pool-71-254-71-233.ronkva.east.verizon.net ([71.254.71.233]:7622
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751078AbWEPCiG (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:38:06 -0400
Message-Id: <200605160158.k4G1wEoc009125@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1 klibc build misbehavior
In-Reply-To: Your message of "Mon, 15 May 2006 23:29:51 +0200."
             <20060515212951.GA1329@mars.ravnborg.org>
From: Valdis.Kletnieks@vt.edu
References: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu> <20060515121630.2a91235b.akpm@osdl.org> <4468E4C7.9040701@zytor.com>
            <20060515212951.GA1329@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147744694_2914P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 21:58:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147744694_2914P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 May 2006 23:29:51 +0200, Sam Ravnborg said:
> On Mon, May 15, 2006 at 01:29:59PM -0700, H. Peter Anvin wrote:
> > Andrew Morton wrote:
> > >Valdis.Kletnieks@vt.edu wrote:
> > >>Why does touching scripts/mod/modpost.c end up rebuilding all of klibc?

> Please post output of make V=1 after touching modpost.c

Blarg.  Now it won't do it.  Checking back, it looks like I managed to
get the ownership/permissions trashed while I was debugging the
modpost.c bug - looks like a 'make modules_install' rebuilt some stuff
as root it shouldn't have, so the next build as non-root was unable to
write some file and that scrogged the build...

Chalk this one up as collateral damage while debugging a real bug. :)

--==_Exmh_1147744694_2914P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEaTG2cC3lWbTT17ARAvH+AJ9GGWlD5iVASwwiKqq1mDbayknUdgCeOcJf
iJCpDlQhZhJ54l9xFGP7yko=
=nhqS
-----END PGP SIGNATURE-----

--==_Exmh_1147744694_2914P--
