Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273292AbTHFCJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273296AbTHFCJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:09:10 -0400
Received: from h80ad2506.async.vt.edu ([128.173.37.6]:12160 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S273292AbTHFCJG (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:09:06 -0400
Message-Id: <200308060208.h7628w5m002801@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5/2.6 NVidia (was Re: 2.4 vs 2.6 ver# 
In-Reply-To: Your message of "Tue, 05 Aug 2003 18:07:00 EDT."
             <200308051807.00179.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <200308051041.08078.gene.heskett@verizon.net> <20030805084533.3b0fd474.rddunlap@osdl.org> <200308051508.19363.gene.heskett@verizon.net>
            <200308051807.00179.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1902191150P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Aug 2003 22:08:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1902191150P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Aug 2003 18:07:00 EDT, you said:

> Now, the factory nvidia drivers will not build for 2.6, so I don't 
> have any X.  Whats the status of the kernel versions vis-a-vis 
> running a gforce2 MMX 32 megger?

(Sorry for replying to the list, but let's get this into the archives in case
people actually search before asking... (yeah right ;))

I'm running the NVidia 4496 drivers right now on 2.6.0-test2-mm4.

Do the following (can be done on a 2.4 kernel if needed)

1) Get the 4496 drivers from NVidia
2) './NVIDIA-Linux-x86-1.0-4496-pkg2.run --extract-only'
3) Go to www.minion.de and get the patch: NVIDIA_kernel-1.0-4496-2.5.diff
4) cd NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv
5)  patch -p1 < NVIDIA_kernel-1.0-4496-2.5.diff
6) cp Makefile.kbuild Makefile

Now *as root*, while running the 2.6 kernel you want support for:
(either single-user or runlevel 3 (No X) are OK here - reboot if needed)

7) cd NVIDIA-Linux-x86-1.0-4496-pkg2/usr/src/nv   if you're not there already.
8) make     this will build the nvidia.ko, copy to /lib/modules, and insmod it for you.
9) cd ../../..      back to the 4496-pgk2 directory
10) 'make install' to put the /usr/lib parts in place.
11) Start X in the usual manner - you've probably got an XFconfig file with the right
NVidia pieces in it already (or you'd not be asking ;)

Hope this helps...
You should be ready to go at that point (note that you will need to do (7) and (8)
each time you do a 'make modules_install', but 9/10 only need doing if/when you
upgrade from 4496 to a new version.




--==_Exmh_1902191150P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/MGM5cC3lWbTT17ARAip5AKDIDKnPCfm/LM1Ecyp1a9N7jBjmAwCgy0eX
SCmkiNuMbO6XCOH4nEllA0I=
=UCV8
-----END PGP SIGNATURE-----

--==_Exmh_1902191150P--
