Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWHKNag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWHKNag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHKNag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:30:36 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3464 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750973AbWHKNag (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:30:36 -0400
Message-Id: <200608110655.k7B6tRse015052@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: Your message of "Thu, 10 Aug 2006 23:17:18 PDT."
             <20060810231718.c2b3fe58.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu> <20060809130151.f1ff09eb.akpm@osdl.org> <200608092043.k79KhKdt012789@turing-police.cc.vt.edu> <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu> <44DB1AF6.2020101@gmail.com> <20060810082749.6b39a07b.akpm@osdl.org> <20060810173312.GC21123@inferi.kami.home> <200608101744.k7AHiXHF004896@turing-police.cc.vt.edu>
            <20060810231718.c2b3fe58.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155279326_2846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 02:55:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155279326_2846P
Content-Type: text/plain; charset=us-ascii

On Thu, 10 Aug 2006 23:17:18 PDT, Andrew Morton said:

> The suspend+resume->hang bug is known and reputedly fixed.
> 
> The stuck-in-lock_page-without-having-done-resume bug is not known. 
> Someone please try the deadline scheduler, or AS.

echo anticipatory >| /sys/block/sda/queue/scheduler
yum -C update yum-updatesd

And yum still hung with the exact same backtrace, so it's not a CFQ bug.


--==_Exmh_1155279326_2846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE3CnecC3lWbTT17ARApXrAKCHUqPN3wKSpTbMo8PlvUmlzsxrqgCgv1AZ
Tx4i1O8dWIJ3p0cL/CgZVRE=
=otKf
-----END PGP SIGNATURE-----

--==_Exmh_1155279326_2846P--
