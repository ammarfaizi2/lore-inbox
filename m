Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTJLQok (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTJLQok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 12:44:40 -0400
Received: from h80ad2602.async.vt.edu ([128.173.38.2]:39808 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263479AbTJLQoj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 12:44:39 -0400
Message-Id: <200310121644.h9CGiUeb011798@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: retu <retu834@yahoo.com>
Cc: Jamie Lokier <jamie@shareable.org>, Kenn Humborg <kenn@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model 
In-Reply-To: Your message of "Sun, 12 Oct 2003 09:04:19 PDT."
             <20031012160419.30891.qmail@web13007.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031012160419.30891.qmail@web13007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_374724705P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Oct 2003 12:44:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_374724705P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Oct 2003 09:04:19 PDT, retu said:

> What's the solution out of this - a clean, open object
> model designed by the core folks, extensible and free
> of licensing issues - and that in the next months.  

The point that seems to be continually missed is that although
it may be a *fine* concept for userspace, it doesn't belong in the
kernel.  There's a syscall barrier for multiple reasons, some technical
and some political/legal.

If anything, we collectively DON'T want to go there because a clever lawyer
could argue that doing a "all the way from kernel to userspace" object-oriented
scheme would make essentially all userspace code a derived work, since it would
be so tightly entwined with the kernel implementation (basically, you'd be
subjecting all of userspace to the same "derived work" limbo that closed-source
kernel modules currently live in).  This could render totally irrelevant this
text from /usr/src/linux/COPYING:

   NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".
 Also note that the GPL below is copyrighted by the Free Software
 Foundation, but the instance of code that it refers to (the Linux
 kernel) is copyrighted by me and others who actually wrote it.

Yes, this would mean that userspace would be GPL'ed as well, and
you'll never see Oracle on a Linux box again for a VERY long time....

--==_Exmh_374724705P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/iYTtcC3lWbTT17ARAnopAJ9tzFQ78Zn53poZ9Aq1eIzCm+DevwCghAgZ
N9+MkDZvVRv5qeVS0MISdjY=
=nLfO
-----END PGP SIGNATURE-----

--==_Exmh_374724705P--
