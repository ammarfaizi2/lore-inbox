Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268565AbTANDo5>; Mon, 13 Jan 2003 22:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268566AbTANDo4>; Mon, 13 Jan 2003 22:44:56 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:22914 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268565AbTANDoz>; Mon, 13 Jan 2003 22:44:55 -0500
Message-Id: <200301140353.h0E3rWqZ004900@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-Reply-To: Your message of "Mon, 13 Jan 2003 22:38:03 EST."
             <20030114033803.GG404@gtf.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030114025452.656612C385@lists.samba.org> <200301140328.h0E3SFqZ004587@turing-police.cc.vt.edu>
            <20030114033803.GG404@gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1507362016P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jan 2003 22:53:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1507362016P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jan 2003 22:38:03 EST, Jeff Garzik said:
> On Mon, Jan 13, 2003 at 10:28:14PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > Out of curiosity, who's job is it to avoid the race condition between when
> > this function takes the strlen() and the other processor makes it a longer
> > string before we return from kmalloc() and do the strcpy()?
> 
> The caller's.

That's cool, long as everybody agrees on that - I've already filled my career
quota of chasing down bugs due to non-threadsafe use of str*() functions. ;)

All the same, I'd probably feel better if it used strncpy() instead - there'd
still be the possibility of copying now-stale data, but at least you'd not be
able to walk off the end of the *new* array's allocated space....

/Valdis


--==_Exmh_1507362016P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I4m8cC3lWbTT17ARAiTKAJ97vumfkUOAplSMG2IQN7rGMQ7wrgCg8PBW
ekSMhqHvDjTVxIw9RK+m928=
=/7gx
-----END PGP SIGNATURE-----

--==_Exmh_1507362016P--
