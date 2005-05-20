Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVETUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVETUXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVETUW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:22:59 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:15880 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261568AbVETUVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:21:18 -0400
Message-Id: <200505202021.j4KKLC3E015961@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: Adam Miller <amiller@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: software RAID 
In-Reply-To: Your message of "Fri, 20 May 2005 16:03:34 EDT."
             <20050520200334.GF23621@csclub.uwaterloo.ca> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
            <20050520200334.GF23621@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116620471_13523P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 May 2005 16:21:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116620471_13523P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 May 2005 16:03:34 EDT, Lennart Sorensen said:

> If you have a bad sector, it doesn't go away by writing to it again.  On
> modern drives, if you see bad sectors the disk is just about dead, and
> will probably be seen as such by the raid system which will then stop
> using the disk entirely and expect you to replace it ASAP.

The one exception here is if you have a miswritten sector (usually caused by
unexpected power-down), which won't read back correctly - but running badblocks
with one of the 'write-verify' options will resurrect it.

If you have a drive that has a bad block in it even *after* badblocks has
re-written it, it's time to replace the drive *now*....

For the original poster: Breaking the mirror and then re-mirroring from the
"good" drive *might* recover the bad block when it re-writes it.  But don't bet
on it...

("power fail" is about the only cause of recoverable bad blocks that I know of -
and if you're having power-fail issues on a RAID, I'd recommend you fix
*THAT* problem before it causes you more grief.  A good UPS will more than pay
for itself in sysadmin sanity and peace of mind....)

--==_Exmh_1116620471_13523P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCjka3cC3lWbTT17ARAkzKAKD9X6Vj9kaIZ0Q8ABFTJuAIFCEFRQCfVyy/
NJ6ag2uJtSL1aBfMg89jF10=
=w2z9
-----END PGP SIGNATURE-----

--==_Exmh_1116620471_13523P--
