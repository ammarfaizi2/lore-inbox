Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWGJPKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWGJPKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWGJPKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:10:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13239 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1422645AbWGJPKk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:10:40 -0400
Message-Id: <200607101510.k6AFAWND006142@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
In-Reply-To: Your message of "Mon, 10 Jul 2006 16:19:06 BST."
             <1152544746.27368.134.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com> <1152524657.27368.108.camel@localhost.localdomain> <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com> <1152537049.27368.119.camel@localhost.localdomain> <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com> <1152539034.27368.124.camel@localhost.localdomain> <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com> <44B26752.9000507@gmail.com> <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>
            <1152544746.27368.134.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152544232_3170P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 11:10:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152544232_3170P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jul 2006 16:19:06 BST, Alan Cox said:
> Ar Llu, 2006-07-10 am 10:57 -0400, ysgrifennodd Jon Smirl:
> > > A few apps do rely on /proc/tty/drivers for the major-minor
> > > to device name mapping. /dev/vc/0 does not exist (unless
> > > created manually) without devfs.
> > 
> > This is why I questioned if /proc/tty was really in use, it contains
> > an entry that is obviously wrong for my system.
> 
> Which tools already know about. What is so hard to understand about the
> idea that pointless random changes break stuff and don't fix things.

On the other hand, a case can be made that if userspace already knows about
the fact the thing is totally broken, fixing it won't break anything. The only
case is that some *already* terminally broken stuff may break further.

Having said that, you're of course correct that we need it done correctly
in /sys, give the tools a chance to catch up, then do the /proc/tty cleanup.

--==_Exmh_1152544232_3170P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEsm3ocC3lWbTT17ARAu31AJ9zV+XoM7Nxy2DP006txjQKe8fX3ACgzDkz
AbiC1Jif4N5ZoJ1dqhxh4N4=
=TXaE
-----END PGP SIGNATURE-----

--==_Exmh_1152544232_3170P--
