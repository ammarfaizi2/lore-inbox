Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269904AbUH0BQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269904AbUH0BQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269908AbUH0BPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:15:12 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:13495 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S269865AbUH0BFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:05:35 -0400
Date: Thu, 26 Aug 2004 19:05:06 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Wichert Akkerman <wichert@wiggy.net>, Spam <spam@tnonline.net>,
       Christer Weinigel <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       jra@samba.org, torvalds@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827010506.GX1262@schnapps.adilger.int>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Wichert Akkerman <wichert@wiggy.net>, Spam <spam@tnonline.net>,
	Christer Weinigel <christer@weinigel.se>,
	Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se> <1906433242.20040826133511@tnonline.net> <20040826113332.GL2612@wiggy.net> <412E7895.7020508@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6pjpgtPchv3bUQQn"
Content-Disposition: inline
In-Reply-To: <412E7895.7020508@namesys.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6pjpgtPchv3bUQQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 26, 2004  16:56 -0700, Hans Reiser wrote:
> Wichert Akkerman wrote:
> >UNIX doesn't have a copy systemcall, applications copy the data
> >manually.
>
> See sys_reiser4()..... ;-)  you can go "A<-B".  I have hopes of getting=
=20
> drive vendors to support us in doing single disk copies without even=20
> leaving the disk drive.....

Yes, we've wanted to have a "copy" syscall for a while now also, so that
Lustre (or other network FS for that matter) can do remote copies of
large files without having to go through the VM of the client.  The work
on sendfile() in 2.6 is a step in that direction, I eagerly await the
day when "cp" will try to do a sys_sendfile() call first, before doing
the read+write looping it does now.

Consider for a network filesystem we are limited to 1/2 of the client
network bandwidth (say 50-75MB/s) for copying instead of the server-local
or multiple server-server bandwidth for copies (400-600MB/s or more).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--6pjpgtPchv3bUQQn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBLojCpIg59Q01vtYRAgxeAKCYWUQ6RQdt0NugDfGnyfYyxy9RrgCaA0ix
zUbxwklCo2WDvGhjMa8kRtE=
=EvgE
-----END PGP SIGNATURE-----

--6pjpgtPchv3bUQQn--
