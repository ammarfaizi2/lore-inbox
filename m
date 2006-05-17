Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWEQUDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWEQUDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 16:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWEQUDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 16:03:17 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:2503
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751069AbWEQUDR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 16:03:17 -0400
Message-Id: <200605172003.k4HK33Wh031483@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
Cc: Olaf Hering <olh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
In-Reply-To: Your message of "Wed, 17 May 2006 15:44:13 EDT."
             <200605171944.k4HJiELo030480@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <20060517081314.GA20415@suse.de> <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu> <20060517091056.GA21219@suse.de> <200605171014.k4HAETHT011371@turing-police.cc.vt.edu> <20060517183710.GA28931@suse.de> <1147892187.10470.70.camel@localhost.localdomain> <20060517190326.GA29017@suse.de>
            <200605171944.k4HJiELo030480@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147896183_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 16:03:03 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147896183_4166P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 May 2006 15:44:13 EDT, Valdis.Kletnieks@vt.edu said:

> As far as I can tell, the boot ROM snarfs up the first 512 byte block, and then
> looks for the 'IBMA' magic cookie, then looks at offset 0x1BE for a
> bog-standard 4-entry partition table, and a 0x55AA at offset 0x1FE.
> 
> Additionally, there will be an *ASCII* '_LVM' in the first 4 bytes of physical
> 512-byte block 7, denoting the start of the LVM control record.
> 
> I'd say if you find both the IBMA *and* _LVM cookies intact, you declare it
> an AIX volume.

Oh, one other check - the partition type(s) are set to 0x08 or 0x09 (AIX
boot and data partition flags).  Other things use those 2 values as well,
but they won't have the _LVM cookie.

--==_Exmh_1147896183_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEa4F3cC3lWbTT17ARAqvhAKDPBw+S1U70xgkcWBnFpt4HbFmsogCgmnPN
KA6Gwl1bmMKesHqvls1jD4w=
=5tu7
-----END PGP SIGNATURE-----

--==_Exmh_1147896183_4166P--
