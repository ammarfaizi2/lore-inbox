Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTFFAPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbTFFAPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:15:20 -0400
Received: from h80ad25b4.async.vt.edu ([128.173.37.180]:10880 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265265AbTFFAPT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:15:19 -0400
Message-Id: <200306060028.h560SkYU002114@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets? 
In-Reply-To: Your message of "Wed, 04 Jun 2003 14:19:34 +0200."
             <37356546941@vcnet.vc.cvut.cz> 
From: Valdis.Kletnieks@vt.edu
References: <37356546941@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-228961070P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Jun 2003 20:28:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-228961070P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Jun 2003 14:19:34 +0200, Petr Vandrovec said:

> > >         FD_ZERO(&set);
> > >         FD_SET(fd, &set);
> > >         select(FD_SETSIZE, NULL, &set, NULL, NULL); <<<<<<< for writing
> > >
> > >         if (FD_ISSET(fd, &set))
> > >                 sendto(fd, &datagram, 1, 0, ...);

> Besides that select() on unconnected socket is nonsense... If you'll
> change code to do connect(), select(), send(), then it should work,
> unless I missed something.

We FD_SET the bit, ignore the return value of select, and test if the bit is
still set.  Plenty of programming bad karma there. However, one would vaguely
hope that the kernel would notice that the socket isn't connected and -ENOTCONN
rather than blocking....


--==_Exmh_-228961070P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+3+A9cC3lWbTT17ARAuJXAKDKQ7nMgh3TpZxAo1kQVteyBf25BQCg9ZZD
nUYReLkzpAI42z+8boIQb8E=
=6Ob2
-----END PGP SIGNATURE-----

--==_Exmh_-228961070P--
