Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTDVU3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTDVU3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:29:17 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23425 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263473AbTDVU3Q (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:29:16 -0400
Message-Id: <200304222041.h3MKfILq027562@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig? 
In-Reply-To: Your message of "Tue, 22 Apr 2003 16:49:03 EDT."
             <3EA5AABF.4090303@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <3EA5AABF.4090303@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1523968674P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Apr 2003 16:41:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1523968674P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Apr 2003 16:49:03 EDT, Timothy Miller <miller@techsource.com>  said:
> Is anyone else able to build 2.5.68 with allyesconfig?
> 
> I'm using RH7.2, so the first thing I did was edit the main Makefile to 
> replace gcc with "gcc3" (3.0.4).  Maybe the compiler is STILL my 
>

1) I think the 3.0.4 compiler had some issues - 3.2.2 may be a better idea.

2) allyesconfig is probably NOT able to build an actual kernel that will
work - in particular, there are a number of pairs/sets of drivers that are
mutually exclusive for a given device. And as you noticed, allyesconfig
will try to build stuff that's known to be b0rken.

3) Even if it works, it will be a huge kernel with lots of stuff you almost
certainly don't need (got an ISDN card? I didn't think so ;).  You would more
likely want to customize the kernel for what you need, or at least consider
using 'allmodconfig' so you can insmod the parts you need and skip the rest.

--==_Exmh_1523968674P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pajucC3lWbTT17ARAnuYAJ98vB5Fg365ST0jiqInnBz7F56WqwCg/Zd5
nVxx10oNodlyuxzM3XPcb24=
=QHHR
-----END PGP SIGNATURE-----

--==_Exmh_1523968674P--
