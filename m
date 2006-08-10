Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWHJRow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWHJRow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWHJRov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:44:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33255 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1422664AbWHJRot (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:44:49 -0400
Message-Id: <200608101744.k7AHiXHF004896@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: Your message of "Thu, 10 Aug 2006 19:33:13 +0200."
             <20060810173312.GC21123@inferi.kami.home>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu> <20060809130151.f1ff09eb.akpm@osdl.org> <200608092043.k79KhKdt012789@turing-police.cc.vt.edu> <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu> <44DB1AF6.2020101@gmail.com> <20060810082749.6b39a07b.akpm@osdl.org>
            <20060810173312.GC21123@inferi.kami.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155231873_3998P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 13:44:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155231873_3998P
Content-Type: text/plain; charset=us-ascii

On Thu, 10 Aug 2006 19:33:13 +0200, Mattia Dongili said:

> oooh, same setup and same trace here, but no yum, see some screenshots
> here:
> http://oioio.altervista.org/linux/dsc03448.jpg
> http://oioio.altervista.org/linux/dsc03449.jpg

Not quite the same trace - the first few lines are the same, but your call to
__lock_page() comes in via do_generic_mapping_read(), while Jiri and I are
seeing the call to __lock_page() coming from truncate_inode_pages_range()....


--==_Exmh_1155231873_3998P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE23CBcC3lWbTT17ARAq57AJwLmJ2h+lPI9e6r1KWb1DWXm/sRaQCdEtsf
S5ExwXqPKlco0WTVwzhpGyA=
=/5CM
-----END PGP SIGNATURE-----

--==_Exmh_1155231873_3998P--
