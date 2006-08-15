Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWHOVAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHOVAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWHOVAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:00:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59796 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750704AbWHOVAf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:00:35 -0400
Message-Id: <200608152100.k7FL0WrU015381@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Irfan Habib <irfan.habib@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum number of processes in Linux
In-Reply-To: Your message of "Tue, 15 Aug 2006 22:59:37 +0500."
             <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155675632_3681P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 17:00:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155675632_3681P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Aug 2006 22:59:37 +0500, Irfan Habib said:
> Hi,
> 
> What is the maximum number of process which can run simultaneously in
> linux? I need to create an application which requires 40,000 threads.
> I was testing with far fewer numbers than that, I was getting
> exceptions in pthread_create

There's some a<<FOO funkiness in the /proc file system that will explode
on 32-bit machines if the process ID goes over 128K.  Of course, with 40K
threads, you're probably either on a 64-bit NUMA box or doing things in an
incredibly ugly way....

--==_Exmh_1155675632_3681P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE4jXwcC3lWbTT17ARAkB1AJ4oFBoU7ryJfeLVeLpnDjsRY9SiDACgpzuP
WcdoMZO6EOYjJZrPbRd3+0U=
=PrYG
-----END PGP SIGNATURE-----

--==_Exmh_1155675632_3681P--
