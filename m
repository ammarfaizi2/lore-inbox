Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVBHRsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVBHRsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVBHRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:48:11 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26898 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261607AbVBHRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:48:07 -0500
Message-Id: <200502081747.j18Hlt54012728@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8) 
In-Reply-To: Your message of "Tue, 08 Feb 2005 11:24:50 CST."
             <20050208172450.GA3598@halcrow.us> 
From: Valdis.Kletnieks@vt.edu
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net>
            <20050208172450.GA3598@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107884875_3999P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Feb 2005 12:47:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107884875_3999P
Content-Type: text/plain; charset=us-ascii

On Tue, 08 Feb 2005 11:24:50 CST, Michael Halcrow said:

> While the program is waiting for a keystroke, mount the block device.
> Enter a keystroke.  The result without the patch is 1, which is a
> security violation.  This occurs because the bd_release function will
> bd_release(bdev) and set inode->i_security to NULL on the close(fd1).

Sounds like a bug, not a feature.  Should it be zeroing out inode->i_security
for an inode with a non-zero reference count?

--==_Exmh_1107884875_3999P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCCPtKcC3lWbTT17ARAtM2AJ0b8z1sXikCbfrCkAfv6M93OEZmawCgic73
UOfHqJ1bVBrCzZj8ji3fUWg=
=OxCR
-----END PGP SIGNATURE-----

--==_Exmh_1107884875_3999P--
