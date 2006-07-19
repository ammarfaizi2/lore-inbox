Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWGSOsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWGSOsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWGSOsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:48:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60589 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964854AbWGSOsE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:48:04 -0400
Message-Id: <200607191447.k6JElwwB004753@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: joel@mainphrame.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: filesystem tuning hints?
In-Reply-To: Your message of "Tue, 18 Jul 2006 20:56:12 PDT."
             <44BDAD5C.5020209@mainphrame.com>
From: Valdis.Kletnieks@vt.edu
References: <44BDAD5C.5020209@mainphrame.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153320478_2943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2006 10:47:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153320478_2943P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Jul 2006 20:56:12 PDT, joel said:

> I also tested ext2 just out of curiosity, and it thrashed all the others
> by a large margin. Could I be doing something really really dumb here,
> or is this just the cost of journalling?

Journalling costs performance at the price of added I/O.

> Are there any dynamic kernel parameters which could bring any of the
> journalled filesystems performance to a more respectable level?

Dynamic parameters?  Probably not.  If you *really* care about performance,
you put the journal on a different physical drive (and maybe controller) than
the actual filesystem itself.  From 'man mkfs.ext3':

       -J journal-options
	...
	                   device=external-journal
                          Attach  the  filesystem  to the journal block device
                          located on external-journal.  The  external  journal
                          must already have been created using the command

                          mke2fs -O journal_dev external-journal


--==_Exmh_1153320478_2943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvkYecC3lWbTT17ARAg3EAJ9s/Map2ikqEkIkjCtaYnMmWCJ2sACeMaQP
OBEW8NLNtl0QElb+I7c4ooA=
=+zTO
-----END PGP SIGNATURE-----

--==_Exmh_1153320478_2943P--
