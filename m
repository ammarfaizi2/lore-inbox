Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbTGTVae (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268644AbTGTVae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:30:34 -0400
Received: from h80ad25d2.async.vt.edu ([128.173.37.210]:16513 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268602AbTGTVa1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:30:27 -0400
Message-Id: <200307202145.h6KLjPGO006430@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mnm2 blank screen in X in RH9.0 Dell c840 laptop 
In-Reply-To: Your message of "Sun, 20 Jul 2003 14:23:41 PDT."
             <20030720212341.87198.qmail@web13302.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030720212341.87198.qmail@web13302.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-408219322P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Jul 2003 17:45:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-408219322P
Content-Type: text/plain; charset=us-ascii

On Sun, 20 Jul 2003 14:23:41 PDT, Ronald Jerome <imun1ty@yahoo.com>  said:
> Is X broken in 2.6.0-test1-mm2?
> 
> I have a blank screen when I "startx"

Are you using the NVidia binary drivers?  If so, you need some patches.

1) Get the 4363 drivers from NVidia's download site.
2) run './NVIDIA-Linux-x86-1.0-4363.run --extract-only'
3) Get the current 4363 patch from www.minion.de
4) 'cd NVIDIA-Linux-x86-1.0-4363/usr/src/nv'
5) patch -p1 < /path/to/NVIDIA_kernel-1.0-4363-2.6.diff
6) cp Makefile.nvidia Makefile

7) boot -test1-mm2 *SINGLE USER*

8) login as root and 'cd NVIDIA-Linux-x86-1.0-4363',
then
9) 'make install'

(I'm typing this on a C840 running -test1-mm2 and the NVidia drivers, so I
know it can be made to work).

--==_Exmh_-408219322P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Gw11cC3lWbTT17ARAsLFAJ9tZIKfPvFoDjwW5xgtbXsIj0m6swCglscY
uZ6JNOMfj/7Cwj304F/0D8Y=
=7dp9
-----END PGP SIGNATURE-----

--==_Exmh_-408219322P--
