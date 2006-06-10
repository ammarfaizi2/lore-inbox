Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWFJBVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWFJBVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWFJBVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:21:50 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:43716
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932615AbWFJBVt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:21:49 -0400
Message-Id: <200606100121.k5A1LDjR004186@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: Your message of "Fri, 09 Jun 2006 17:21:08 MDT."
             <20060609232108.GM5964@schatzie.adilger.int>
From: Valdis.Kletnieks@vt.edu
References: <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net> <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net> <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org> <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com> <m3odx2b86p.fsf@bzzz.home.net> <200606092252.k59Mqc2Q018613@turing-police.cc.vt.edu>
            <20060609232108.GM5964@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149902472_2692P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 21:21:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149902472_2692P
Content-Type: text/plain; charset=us-ascii

On Fri, 09 Jun 2006 17:21:08 MDT, Andreas Dilger said:

> You mount with the new kernel without "-o extents", and find files with
> extents "lsattr -R /mnt/tmp | awk '/----e / print { $2 }'", copy those
> files, mv over old files, unmount.

How do you "copy those files" when you don't have extent support at that
point?  Remember - the whole problem here is that if you don't have
extent support, you can't read the file, it's backward-incompatible.
(If you *are* able to read the file even without extents, then this whole
thread is total BS).

You can certainly at least try to copy them to another file system
while the source *is* mounted with -o extents, and then mount without it
and copy the files back, but (a) that isn't what you said and (b) it doesn't
work for files over 2T or so..

--==_Exmh_1149902472_2692P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEih6IcC3lWbTT17ARAqscAKDUzF6V1RXOYdUDZB9bwJeCoEKwDgCgzPfY
4YMnHNclmfZ5L2pzrszdO98=
=QJ21
-----END PGP SIGNATURE-----

--==_Exmh_1149902472_2692P--
