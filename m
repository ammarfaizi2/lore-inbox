Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTETALy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTETALx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:11:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52900 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262874AbTETALw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:11:52 -0400
Message-Id: <200305200024.h4K0OnPc025466@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc 
In-Reply-To: Your message of "Mon, 19 May 2003 17:55:06 MDT."
             <m14r3q331h.fsf@frodo.biederman.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030519165623.GA983@mars.ravnborg.org> <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com> <babhik$sbd$1@cesium.transmeta.com> <m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com> <m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>
            <m14r3q331h.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1300630288P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 May 2003 20:24:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1300630288P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 May 2003 17:55:06 MDT, Eric W. Biederman said:
> If things must be maintained in concert it is a bug.  
> 
> With a fixed ABI people take advantage of new features as they
> care for them.  And in general to use new features requires new code.

And if the kernel headers aren't maintained in concert with the kernel,
new userspace code can't reach the new features.

Therefor, by your definition, the current situation is a bug.

Try compiling code that uses futexes on a system that has a kernel that
supports them, but kernel-headers that haven't been upgraded to mention them.
The kernel has the new code, the userspace has the new code, but gcc will
turn around and whinge about the new code because there's a piece missing in
between.  So people *CANT* take advantage of the new features (unless they
do something silly like drag their own foo.h file around where it can get
out of sync with reality).


--==_Exmh_-1300630288P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+yXXQcC3lWbTT17ARAqXlAJ9B/F3OBLLh9yeK6shkWYN8jdzMBACcCMsC
t64Solrib4GAqf86Ow9ot9w=
=ViKe
-----END PGP SIGNATURE-----

--==_Exmh_-1300630288P--
