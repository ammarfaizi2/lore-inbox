Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272995AbTHKSSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273068AbTHKSP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:15:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54144 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272997AbTHKSOh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:14:37 -0400
Message-Id: <200308111800.h7BI0o0r030965@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove useless assertions from reiserfs 
In-Reply-To: Your message of "Mon, 11 Aug 2003 13:45:30 EDT."
             <3F37D63A.8010500@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <E19mFqr-00068B-00@tetrachloride>
            <3F37D63A.8010500@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-648034984P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Aug 2003 14:00:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-648034984P
Content-Type: text/plain; charset=us-ascii

On Mon, 11 Aug 2003 13:45:30 EDT, Jeff Garzik said:
> Why are these useless?

> >  	if (len >= 12)
> >  	{          
> >      //assert(len < 16);
> >               if (len >= 16)
> >                    BUG();
> 
> Seems like a valid check to me...

Just before that, there's code:

     while(len >= 16)
        {
	...
                len -= 16;
            }

So if that ever exits with a len >=16, we have a SERIOUS problem with
either the compiler or the hardware - as such, that "if (..) BUG" is dead code.
Similarly for the other checks.

--==_Exmh_-648034984P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/N9nScC3lWbTT17ARAs8CAJ9YLu92aQWlhKnO/RPV+vo/rY31rwCdGgEn
s7xwgMS0hppavfYFZ0O3IlM=
=cz8Q
-----END PGP SIGNATURE-----

--==_Exmh_-648034984P--
