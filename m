Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUGPUlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUGPUlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUGPUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:41:42 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:39394 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266569AbUGPUli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:41:38 -0400
Date: Fri, 16 Jul 2004 14:41:35 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: ext3: bump mount count on journal replay
Message-ID: <20040716204135.GG6770@schnapps.adilger.int>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20040714131525.GA1369@elf.ucw.cz> <20040714200554.GR23346@schnapps.adilger.int> <20040714203258.GC25802@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
In-Reply-To: <20040714203258.GC25802@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pE2VAHO2njSJCslu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 14, 2004  22:32 +0200, Pavel Machek wrote:
> > AFAICS, this just means that if you have an ext3 filesystem
> > (i.e. has_journal) that you will fsck 5x as often, not so great.  You
> > should instead check for INCOMPAT_RECOVER instead of HAS_JOURNAL.
>=20
> Oops, you are right. Updated patch is attached.

No patch was attached.

> > Instead, you could change this to only increment the mount count after
> > a clean unmount 20% of the time (randomly).  Since most people bitch
> > about the full fsck anyways this is probably the better choice than
> > increasing the frequency of checks and forcing the users to change the
> > check interval to get the old behaviour.
>=20
> Nice hack.... would that be acceptable?

It's OK by me.  I don't think you'll get complaints from users if it is
checked less often (there is still the time-based check).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA+D1/pIg59Q01vtYRAhFeAKDlGTtF2Qts0LoXb0Ixv567PHPyiACgsOJK
gLSXosi+GTpWs8Ywp/xWDCw=
=MG/H
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--
