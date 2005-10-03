Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVJCBF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVJCBF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVJCBF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:05:27 -0400
Received: from h80ad24a6.async.vt.edu ([128.173.36.166]:22228 "EHLO
	h80ad24a6.async.vt.edu") by vger.kernel.org with ESMTP
	id S932100AbVJCBF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:05:27 -0400
Message-Id: <200510030104.j9314mQC028482@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up 
In-Reply-To: Your message of "Sun, 02 Oct 2005 12:27:26 +0200."
             <20051002102726.GB26677@opteron.random> 
From: Valdis.Kletnieks@vt.edu
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu> <20050923153158.GA4548@x30.random> <1127509047.8880.4.camel@kleikamp.austin.ibm.com> <1127509155.8875.6.camel@kleikamp.austin.ibm.com> <1127511979.8875.11.camel@kleikamp.austin.ibm.com> <20050928223829.GH10408@opteron.random> <1128126424.10237.7.camel@kleikamp.austin.ibm.com>
            <20051002102726.GB26677@opteron.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128301486_12821P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Oct 2005 21:04:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128301486_12821P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <28472.1128301486.1@turing-police.cc.vt.edu>

On Sun, 02 Oct 2005 12:27:26 +0200, Andrea Arcangeli said:

> Ok great this explain things, so perhaps my last hack attempt of not
> accounting the unstable pages in the "nr_reclaimable" isn't needed.
> 
> What about Valids, were you using jfs too along with ext3? If a single
> fs has a bug the loop can happen (it could happen in mainline too,
> except it was less likely to be visible there).

% zgrep -i jfs /proc/config.gz 
# CONFIG_JFS_FS is not set

Sorry, this is an ext3-based system, no JFS here.

Another (possibly unimportant) data point:  I was seeing it with 256M
of RAM, but after a recent upgrade to 768M, I'm not seeing it.  Probably
need to reboot with mem=256 to replicate now...

--==_Exmh_1128301486_12821P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQIOucC3lWbTT17ARAoiIAJ9JfWt4mcAz6e1BRPqfvnhYnDsa1gCgt8ZM
4Z/NR4zOBWPPQIIHRXtA7zQ=
=ICjM
-----END PGP SIGNATURE-----

--==_Exmh_1128301486_12821P--
