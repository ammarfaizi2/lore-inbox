Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUDNGxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263924AbUDNGxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:53:47 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:30213 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S263923AbUDNGxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:53:42 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-38-539098720"
Message-Id: <36927C82-8DE0-11D8-A41D-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: Hans Reiser <reiser@namesys.com>, Atul Mukker <atulm@lsil.com>
From: Paul Wagland <paul@wagland.net>
Subject: reiser4 and megaraid problems with debian 2.6.5
Date: Wed, 14 Apr 2004 08:51:53 +0200
To: Linux mailing list SCSI <linux-scsi@vger.kernel.org>,
       Linux mailing list kernel <linux-kernel@vger.kernel.org>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-38-539098720
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi all,

I would like to report on a problem that I am having. I am just testing 
out the new megaraid unified driver, and have been doing some baseline 
testing with bonnie++.

My problem is that, although reiserfs, ext2, jfs and xfs all work, 
reiser4 fails with the following error:
---
Can't write block.
Bonnie: drastic I/O error (write(2)): No such file or directory
---

I am using the debian prepared kernel with the debian reiser4 patch. I 
made a cursory examination of the patch, and it appears to correlate 
fairly closely with the patch from the namesys site.

Given that this works with reiserfs, ext2, jfs and xfs it would appear 
to be a reiser4 problem, however ext3 also fails, though with a 
different error, it claims that the disk is full, but it is trying to 
write a 2 1GB files onto a 2.5GB filesystem, so it should have enough 
room, and indeed it did even work two or three times out of about 10 
runs (lots of timing :-). This implies that it might be a megaraid 
problem. As you can tell, I really have no idea ;-)

I will try playing around tonight with an official kernel and the 
official reiser4 patch to see if that makes any difference, but would 
just like to raise this potential problem sooner rather than later.

If I can help debug this situation (I am probably the only person 
trying this combination :-) please let me know how I should go about 
it.

Cheers,
Paul

--Apple-Mail-38-539098720
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAfN/Gtch0EvEFvxURAjJAAJ9IZWLkegspJPO15jquCWtL5Y3bpwCgp3Qi
k1qzANrgx1BYYszngh91d5M=
=JqxC
-----END PGP SIGNATURE-----

--Apple-Mail-38-539098720--

