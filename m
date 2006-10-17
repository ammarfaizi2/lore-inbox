Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWJQS6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWJQS6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWJQS6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:58:20 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48018 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750995AbWJQS6T (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:58:19 -0400
Message-Id: <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: jens.axboe@oracle.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
In-Reply-To: Your message of "Tue, 17 Oct 2006 20:41:41 +0200."
             <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1161111472_5919P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 14:57:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1161111472_5919P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 Oct 2006 20:41:41 +0200, Jan Engelhardt said:

> fs/Kconfig has:
> 
> if BLOCK
> menu "DOS/FAT/NT Filesystems"

> Why is it wrapped into BLOCK, or, why are all of the other filesystems 
> which require a block device?

Some filesystems (such as /proc, /sys, and so on - basicaly, the "pseudo" file
systems) are able to stand by themselves.  Filesystems that read actual blocks
of data off actual media will require the services of the block layer to do
that.  So if you've built a tiny embedded kernel that doesn't include the block
layer, you can't read those sorts of filesystems....



--==_Exmh_1161111472_5919P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFNSewcC3lWbTT17ARAvvXAKCdUoWyefoUBU+n5U47aVNWiRaWEACghUTW
LIa6k+Ohu6FWd+gcnRknEfc=
=B/G7
-----END PGP SIGNATURE-----

--==_Exmh_1161111472_5919P--
