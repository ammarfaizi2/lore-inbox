Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267031AbUBMOXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267024AbUBMOWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:22:48 -0500
Received: from h80ad25ab.async.vt.edu ([128.173.37.171]:35677 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267002AbUBMOWp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:22:45 -0500
Message-Id: <200402131422.i1DEMWVB011960@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
Cc: der.eremit@email.de, linux-kernel@vger.kernel.org
Subject: Re: Initrd Question 
In-Reply-To: Your message of "Fri, 13 Feb 2004 17:14:25 +0300."
             <E1Are5J-000KGt-00.arvidjaar-mail-ru@f22.mail.ru> 
From: Valdis.Kletnieks@vt.edu
References: <E1Are5J-000KGt-00.arvidjaar-mail-ru@f22.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1560199420P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 09:22:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1560199420P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 17:14:25 +0300, =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= said:

> > Should you check for /dev/.devfsd on the real root here? I thought .devfsd
> > is created by the devfsd process, 
> 
> you are wrong here, sorry. .devfsd is created by devfs.

I see the confusion - .devfsd gets created in the directory that is
/dev at the time devfs starts up.  However, after pivot_root, that directory
has a new name, and that's where we need to check for .devfsd.

It gets even more confusing in some configurations where we end up unmounting
/initrd/dev and then re-mounting /dev just to get it into the right place..

--==_Exmh_-1560199420P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALN2ncC3lWbTT17ARApcbAJ0Wgz81BxuWLEOak5DdQi60d91LAACgyx2s
/CBGTkkmRhttwSTZepvLKGg=
=KJLK
-----END PGP SIGNATURE-----

--==_Exmh_-1560199420P--
