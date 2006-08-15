Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWHOXio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWHOXio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWHOXio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:38:44 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17834 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750816AbWHOXin (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:38:43 -0400
Message-Id: <200608152338.k7FNccMI021012@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: Your message of "Wed, 09 Aug 2006 15:06:35 EDT."
             <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
            <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155685118_3681P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 19:38:38 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155685118_3681P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Aug 2006 15:06:35 EDT, Valdis.Kletnieks@vt.edu said:
> Yum managed to get wedged: 'echo t > /proc/sysrq-trigger' says:
> 
> [ 4514.840000] yum           D D5C32AA0     0  4747   4430                     (NOTLB)
> [ 4514.840000]        d5c3dda4 d5c3dd78 00000007 d5c32aa0 bd3ddd00 00000338 00000000 d5c32bc0
> [ 4514.840000]        c1601628 d5c3dd9c 64600300 0000001f d5c3ddd8 d5c3ddd8 c1601628 d5c3ddac
> [ 4514.840000]        c034fef8 d5c3ddb4 c0136e8e d5c3ddcc c0350026 c0136e58 d5c3ddd8 00000000
> [ 4514.840000] Call Trace:
> [ 4514.840000]  [<c034fef8>] io_schedule+0x25/0x44
> [ 4514.840000]  [<c0136e8e>] sync_page+0x36/0x3a
> [ 4514.840000]  [<c0350026>] __wait_on_bit_lock+0x30/0x58
> [ 4514.840000]  [<c0136e44>] __lock_page+0x51/0x59
> [ 4514.840000]  [<c013f099>] truncate_inode_pages_range+0x1de/0x230
> [ 4514.840000]  [<c013f0f7>] truncate_inode_pages+0xc/0x11
> [ 4514.840000]  [<c018ea12>] ext3_delete_inode+0x16/0xbd
> [ 4514.840000]  [<c016798f>] generic_delete_inode+0xb6/0x130
> [ 4514.840000]  [<c0167a1b>] generic_drop_inode+0x12/0x166
> [ 4514.840000]  [<c01673f1>] iput+0x67/0x6a
> [ 4514.840000]  [<c0165662>] dentry_iput+0x97/0xcc
> [ 4514.840000]  [<c016613d>] dput+0x183/0x19c
> [ 4514.840000]  [<c015f64f>] sys_renameat+0x17a/0x1d3
> [ 4514.840000]  [<c015f6ba>] sys_rename+0x12/0x14
> [ 4514.840000]  [<c0102849>] sysenter_past_esp+0x56/0x79

Well, after a detour into hardware issues (a dying fan ended up escalating
into swapping a motherboard), I built 2.6.18-rc4-mm1 - unable to replicate
the 'yum' hang on that.  Somehow, I'm not feeling very motivated to do a
bisect of -rc3-mm2 to find it, unless somebody thinks we should track it down
just in case it's just in hiding....

--==_Exmh_1155685118_3681P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFE4lr+cC3lWbTT17ARAngkAKDXElqDs7xfJhlh0kW7ICUpoiVIYACTBqP1
xCMyDioFUV1YE3mRDTzExw==
=dcZ1
-----END PGP SIGNATURE-----

--==_Exmh_1155685118_3681P--
