Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUKWVEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUKWVEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKWVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:03:04 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55467 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261560AbUKWVCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:02:19 -0500
Message-Id: <200411232102.iANL2H5T025781@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Bruce Korb <bkorb@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing build functionality? 
In-Reply-To: Your message of "Tue, 23 Nov 2004 12:33:39 PST."
             <41A39EA3.B8AD9C13@veritas.com> 
From: Valdis.Kletnieks@vt.edu
References: <41A39EA3.B8AD9C13@veritas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_741560600P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 23 Nov 2004 16:02:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_741560600P
Content-Type: text/plain; charset=us-ascii

On Tue, 23 Nov 2004 12:33:39 PST, Bruce Korb said:

> Anyway, I do not see an obvious way to construct an object archive library
> that I wish to use for multiple drivers.  There are two problems.  This:
> 
> > ifeq ($(ARCH),ia64) 
> > 	CFLAGS_KERNEL = 
> > endif
> 
> because I am making the archive for a loadable driver. 

The usual solution for 2 modules that share an archive would be to create
*three* modules driver-a, driver-b, and driver-core - and then have the
appropriate depmod magic so a 'modprobe driver-a' does an insmode driver-core,
as does a 'modprobe driver-b'.

Otherwise, you're just loading the entire library into memory twice,
once for each driver...

--==_Exmh_741560600P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBo6VYcC3lWbTT17ARAjbIAKDCzVTCAsR6npT8rUNtic9fImxPhgCfRoAz
cQDFrVEZw5GI/W3NhwgMOi4=
=Waiy
-----END PGP SIGNATURE-----

--==_Exmh_741560600P--
