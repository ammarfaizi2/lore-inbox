Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWGFUwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWGFUwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWGFUwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:52:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53991 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750844AbWGFUwi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:52:38 -0400
Message-Id: <200607062052.k66KqMDH027923@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: ric@emc.com
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
In-Reply-To: Your message of "Thu, 06 Jul 2006 13:27:35 EDT."
             <44AD4807.6090704@emc.com>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <44AD286F.3030507@emc.com> <m3ejwyiryr.fsf@defiant.localdomain>
            <44AD4807.6090704@emc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152219142_2882P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jul 2006 16:52:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152219142_2882P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Jul 2006 13:27:35 EDT, Ric Wheeler said:

> The key is to keep the signature/checksum with the file - tripwire and 
> backup programs could do this (and even store it their own extended 
> attribute), but I think that it is more generically useful than that. 

Backup programs want it stored with the file.  Tripwire wants it stored
as far away from the file as possible.  Remember - for Tripwire, we *don't*
want the "current maintained value", we want "the snapshotted value from
a known good state".

If the filesystem stored a "guaranteed trustable current hash", Tripwire
*could* use it to compare against its database rather than having to re-read
the file and recompute it.  Unfortunately, a useful trustable hash is
basically incompatible with any sort of incremental updating (except for
the special case of appending to the file).

--==_Exmh_1152219142_2882P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErXgGcC3lWbTT17ARAh/lAJ49a/EribWDVq906CmG97lcsHlKAACfTJId
25TXFQhBbdPFfexVTUCde8E=
=8NP7
-----END PGP SIGNATURE-----

--==_Exmh_1152219142_2882P--
