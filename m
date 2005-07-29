Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVG2Loh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVG2Loh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVG2Loh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:44:37 -0400
Received: from mx2.mail.ru ([194.67.23.122]:52268 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262506AbVG2Log (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:44:36 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Syncing single filesystem (slow USB writing)
Date: Fri, 29 Jul 2005 15:44:19 +0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200507290731.32694.arvidjaar@mail.ru> <200507291428.06903.arvidjaar@mail.ru> <20050729042000.48c40272.akpm@osdl.org>
In-Reply-To: <20050729042000.48c40272.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1495364.8tolr6haND";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507291544.23545.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1495364.8tolr6haND
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 July 2005 15:20, Andrew Morton wrote:
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > On Friday 29 July 2005 07:50, Andrew Morton wrote:
> > > > One idea how to improve situation - continue to mount with dsync
> > > > (having basically old case) and do frequent sync of filesystem (this
> > > > culd be started as HAL callout or whatever). Unfortunately, I could
> > > > not find a way to request a sync (flush) of single mount point or
> > > > block device. Have I missed something?
> > >
> > > It's trivial to do in-kernel but no, I'm afraid there isn't a userspa=
ce
> > > interface for this.
> >
> > apparently one should not ask such a question at 7 am. Any reason why
> > BLKFLSBUF does not suite?
>
> That'll only write back data associated with /dev/hdXX (ie: filesystem
> metadata) and not the data associated with all the files in the filesystem
> which is mounted on /dev/hdXX.

I am confused. BKLFLSBUF boils down to sync_inodes_sb for mounted device, a=
nd=20
that appears to write out direty inode pages?

What should be used for in-kernel implementation then? I was going to use t=
he=20
same frankly speaking :)

--nextPart1495364.8tolr6haND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC6haXR6LMutpd94wRAjIxAKCBqIjHa4KEV9YQE15eCHi+3vV9oQCbB1gC
8WVDOjX+L3rotVlD34Ls6Co=
=ATYb
-----END PGP SIGNATURE-----

--nextPart1495364.8tolr6haND--
