Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUFBSvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUFBSvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUFBStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:49:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52870 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263815AbUFBSsY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:48:24 -0400
Message-Id: <200406021848.i52Im0Xn000958@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: mitya@school.ioffe.ru (Dmitry Baryshkov)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled 
In-Reply-To: Your message of "Wed, 02 Jun 2004 21:48:10 +0400."
             <20040602174810.GA31263@school.ioffe.ru> 
From: Valdis.Kletnieks@vt.edu
References: <20040602174810.GA31263@school.ioffe.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1380173504P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 14:48:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1380173504P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jun 2004 21:48:10 +0400, mitya@school.ioffe.ru (Dmitry Baryshkov)  said:
> Hello,
> 
> I tried enabling SELinux on my Linux-box, using ReiserFS as /, kernel
> 2.6.7-rc2.
> 
> After relabeling and rebooting in non-enforcing mode everything worked
> well, exept the fact, that new files on reiserfs filesystems don't get
> security attributes.
> 
> So I added 'fs_use_xattr reiserfs system_u:object_r:fs_t;' to the policy,
> rebooted and found, that mount hangs during opening of /etc/mtab~<pid>
> (even in non-enforcing mode).

Does your .config include CONFIG_REISERFS_FS_XATTR?  Very Bad Things
are likely to happen if not.....

--==_Exmh_1380173504P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAviDgcC3lWbTT17ARAjUfAJ9V7/h0DZuUq5+nGueDtmn8epHI4QCgluwh
YhAP6svfKBitmGK6knw06YI=
=VWGH
-----END PGP SIGNATURE-----

--==_Exmh_1380173504P--
