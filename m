Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUIQU1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUIQU1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268977AbUIQU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:27:46 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60295 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268972AbUIQU1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:27:42 -0400
Message-Id: <200409172027.i8HKRVwY005444@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Eric Mudama <edmudama@gmail.com>
Cc: David Stevens <dlstevens@us.ibm.com>, Netdev <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design 
In-Reply-To: Your message of "Fri, 17 Sep 2004 00:46:59 MDT."
             <311601c90409162346184649eb@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <4148991B.9050200@pobox.com> <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
            <311601c90409162346184649eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-239910029P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Sep 2004 16:27:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-239910029P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Sep 2004 00:46:59 MDT, Eric Mudama said:
> On Wed, 15 Sep 2004 14:11:04 -0600, David Stevens <dlstevens@us.ibm.com> wrot
e:
> > Why don't we off-load filesystems to disks instead?
> 
> Disks have had file systems on them since close to the beginning...

No, he means "offload the processing of the filesystem to the disk itself".

IBM's MVS  systems basically did that - it used the disk's "Search Key" I/O
opcodes to basically get the equivalent of doing namei() out on the disk itself
(it did this for system catalog and PDS directory searches from the beginning,
and added 'indexed VTOC' support in the mid-80s).  So you'd send out a CCW
(channel command word) stream that basically said "Find me the dataset
USER3.ACCTING.TESTJOBS", and when the I/O completed, you'd have the DSCB (the
moral equiv of an inode) ready to go.


--==_Exmh_-239910029P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBS0izcC3lWbTT17ARAoKMAJ4pA1BjsPb0sbxLDbLKM9jvox5srACeMV0V
ZMot5U1QnkpacHYr8pIWeJM=
=zjf/
-----END PGP SIGNATURE-----

--==_Exmh_-239910029P--
