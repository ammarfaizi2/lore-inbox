Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTETA7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTETA6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:58:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6310 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263333AbTETA6V (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:58:21 -0400
Message-Id: <200305200111.h4K1BJPc026622@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc 
In-Reply-To: Your message of "Mon, 19 May 2003 18:40:18 MDT."
             <m1y9121mdp.fsf@frodo.biederman.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030519165623.GA983@mars.ravnborg.org> <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com> <babhik$sbd$1@cesium.transmeta.com> <m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com> <m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com> <m14r3q331h.fsf@frodo.biederman.org> <200305200024.h4K0OnPc025466@turing-police.cc.vt.edu>
            <m1y9121mdp.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1177108798P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 May 2003 21:11:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1177108798P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 May 2003 18:40:18 MDT, Eric W. Biederman said:

> Or the build against a library that does that.  There are not that
> many libraries.

So I get around the lack of  foo-gram support in glibc by
writing/compiling/installing a -lfoo-gram, which of course gets its
header definitions from the same header file that kernheaders isn't
supplying, or by dragging around the same local foo-gram.h that I'd
otherwise be dragging around with my app.

Somehow, this doesn't seem like progress to me.  And of course, it just
sets me up for *odd* debugging problems when my foo-gram.h is at version
0.17 and the kernel and glibc are up to 0.25, and features mysteriously
misbehave depending on the exact -I include order on the system I'm
doing the build on, and whether the particular version of gcc has the
automagic auto-ambush handling of /usr/local/include, and the phase of
the moon...

Yes, I know I can build against a library.  Point is that saying I can
do it doesn't change the fact it's a hack and an ongoing maintenance problem.

> For a lot of system calls it is actively dangerous to assume dev_t ==
> __kernel_dev_t.  As glibc does some cute things in there.

I thought that sort of fun and games was *WHY* userspace can't use the
kernel headers in the first place?

--==_Exmh_-1177108798P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+yYC2cC3lWbTT17ARApMiAKD8DJ3R4DzFj8HydKjBGRSywh0g9ACfZAvr
JbwciMFvlUAYjkyoPlllbZk=
=dF0P
-----END PGP SIGNATURE-----

--==_Exmh_-1177108798P--
