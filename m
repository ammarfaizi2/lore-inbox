Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWEQNU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWEQNU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWEQNU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:20:27 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:56771
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932264AbWEQNU0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:20:26 -0400
Message-Id: <200605171319.k4HDJwhv015404@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux cbon <linuxcbon@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: Your message of "Wed, 17 May 2006 14:39:37 +0200."
             <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147871986_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 09:19:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147871986_4166P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2006 14:39:37 +0200, linux cbon said:

> If we have a new window system, shall all applications
> be rewritten ?

No.  /bin/cat and /bin/ls will survive unscathed.  However, if you
have a graphical application, it will need reworking.  That's a LOT
of code.

> My idea is that the kernel should include universal
> graphical support.

And if we discover the API is wrong, or there's a bug, what then?

Or if you just want to try a different window manager?

> And then we would NOT need ANY window system AT ALL.

And if Gnome is in the kernel, what do all the KDE and Enlightenment
users supposed to do?

> It would be faster, simpler, easier to manage etc.

It wouldn't be faster, and it wouldn't be simpler, and it wouldn't be
easier to manage.

Come back when you've examined all the code in libX11 (that's just *one*
of the libraries), and identified *all* the locking issues, put in
schedule() calls at all the right places to allow pre-emption, and conver=
ted
it to use only 16K of stack space (that's *generous* - if it were in the
kernel, it would have a lot less than 16K available).

And consider that currently, you can update your kernel and usually not
need to make much change to your Xorg source tree, and vice versa.  A bug=

in Xorg doesn't force a kernel upgrade.  Now imagine that you hit a bug
in Xorg that's fixed in the 2.6.28 kernel - but releases after 2.6.26 don=
't
boot on your hardware because of a bug with the SATA disk controller you
have.

And if my X server dies on me, I don't usually need to wait for the
entire system to reboot.  If it was in the kernel, it just became a
panic/reboot rather than =22init respawns gdm and life goes on=22.

I'm idly wondering how many years of actual system kernel hacking and
sysadmin experience you have - I know for a fact that I've been doing it
for a living since well before many frequent posters to this list were
even born (Hi, Kyle=21 :)  And the single most important point I've learn=
ed
in almost 30 years of making a living at it is:

There is *nothing* that ruins a sysadmin's entire week as badly as a
lengthy pre-req chain.  =22We need to upgrade A, but that requires a new
release of B, which means we need to upgrade C as well, but the next
release of C won't work with hardware J of ours...=22.   People who
complain about Red Hat systems having =22pre-req hell=22 with RPMs are
wimps - I've *never* seen a pre-req chain since Red Hat 7.0 that was more=

than 5 or 7 RPM's deep.  IBM's AIX 3 often had pre-req chains over
100 deep - I once had a *single* bugfix against one /etc script replace
*literally* over 3/4 of /usr....)

--==_Exmh_1147871986_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEayLycC3lWbTT17ARAhrGAJ9FvFKXzb6H8REDhdzVhqFNJkIowwCggqUB
fFTRL5NXzPNEGQS3lsVTldI=
=c02K
-----END PGP SIGNATURE-----

--==_Exmh_1147871986_4166P--
