Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUHWXcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUHWXcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUHWXaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:30:15 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:5837 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268410AbUHWX2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:28:11 -0400
Date: Mon, 23 Aug 2004 17:28:02 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH][2/7] xattr consolidation - LSM hook changes
Message-ID: <20040823232802.GD1262@schnapps.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>, Andreas Gruenbacher <agruen@suse.de>
References: <Xine.LNX.4.44.0408231414270.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231415310.13728-100000@thoron.boston.redhat.com> <20040823200353.A20114@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20040823200353.A20114@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 23, 2004  20:03 +0100, Christoph Hellwig wrote:
> On Mon, Aug 23, 2004 at 02:16:17PM -0400, James Morris wrote:
> > This patch replaces the dentry parameter with an inode in the LSM
> > inode_{set|get|list}security hooks, in keeping with the ext2/ext3 code.
> > dentries are not needed here.
>=20
> Given that the actual methods take a dentry this sounds like a bad design.
> Can;t you just pass down the dentry through all of the ext2 interfaces?
>=20
> (And again, mid-term these checks should move to the VFS)

Actually, I recall something about it being desirable to pass the dentry
down instead of just the inode, maybe Andreas G. recalls?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBKn2CpIg59Q01vtYRAv6oAJ4lXLbCXqepxMCGCe9qOtEYov5IKQCfa6WG
rlgoRmJcjhlRh/bUGvYqeq8=
=gTm6
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
