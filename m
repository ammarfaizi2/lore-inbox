Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVBUTqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVBUTqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBUTqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:46:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47111 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262085AbVBUTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:45:50 -0500
Message-Id: <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Anthony DiSante <theant@nodivisions.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups 
In-Reply-To: Your message of "Mon, 21 Feb 2005 14:18:44 EST."
             <421A3414.2020508@nodivisions.com> 
From: Valdis.Kletnieks@vt.edu
References: <421A3414.2020508@nodivisions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109015141_9072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Feb 2005 14:45:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109015141_9072P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Feb 2005 14:18:44 EST, Anthony DiSante said:

> It seems like this problem is always going to exist, because some hardware 
> and some drivers will always be buggy.  So shouldn't we have some sort of 
> watchdog higher up in the kernel, that watches for hung processes like this 
> and kills them?

And said watchdog would clean up the mess, how, exactly?  There's lots of sticky
issues having to do with breaking locks and possibly still-pending I/O (I once had
a tape drive complete an I/O 3 *days* after the request was sent - good thing no
watchdog killed the process and deallocated the memory that I/O landed in ;)

It's been covered before, look in the lkml archives for details.

--==_Exmh_1109015141_9072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCGjplcC3lWbTT17ARAuI0AKC6A/ZxTvdUtjHy9LMniix2NiLjtACgjSIp
roswn0PTkPJd01fSru5puno=
=HbrY
-----END PGP SIGNATURE-----

--==_Exmh_1109015141_9072P--
