Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWGQSJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWGQSJW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWGQSJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:09:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17310 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751118AbWGQSJV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:09:21 -0400
Message-Id: <200607171808.k6HI8kjL018161@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Hans Reiser <reiser@namesys.com>
Cc: Jeffrey Mahoney <jeffm@suse.com>, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
In-Reply-To: Your message of "Sun, 16 Jul 2006 20:02:27 PDT."
             <44BAFDC3.7020301@namesys.com>
From: Valdis.Kletnieks@vt.edu
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com>
            <44BAFDC3.7020301@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153159726_13479P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jul 2006 14:08:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153159726_13479P
Content-Type: text/plain; charset=us-ascii

On Sun, 16 Jul 2006 20:02:27 PDT, Hans Reiser said:

> Create a mountpoint which knows how to resolve a/b without using a
> "directory".

And said mountpoint gets past the '/' interpretation in the VFS, how, exactly?

fs/namei.c, do_path_lookup() does magic on a '/' on about the 3rd line.
So you're going to get handed 'a'.

--==_Exmh_1153159726_13479P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEu9IucC3lWbTT17ARAtwoAJ4qfPzyWr0+tF5LqSDEHJ9Krd9H/gCguaw+
1egFENzXzu6Z6BoFu2XlVs0=
=ZXoz
-----END PGP SIGNATURE-----

--==_Exmh_1153159726_13479P--
