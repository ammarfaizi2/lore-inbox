Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWBIWoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBIWoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWBIWoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:44:21 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:969 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750708AbWBIWoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:44:20 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Fri, 10 Feb 2006 08:16:13 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209092555.GB2940@elf.ucw.cz> <200602091422.40738.rjw@sisk.pl>
In-Reply-To: <200602091422.40738.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17017351.8LNp0xOsml";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602100816.18904.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart17017351.8LNp0xOsml
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 09 February 2006 23:22, Rafael J. Wysocki wrote:
> > > I've begun briefly to have a look at this.
> > >
> > > Part of the problem I have, both with doing incremental patches for
> > > swsusp and with doing a userspace version, is that some of the
> > > fundamentals are redesigned in suspend2. The most important of these =
is
> > > that we store the metadata in bitmaps (for pageflags) and extents (for
> > > storage) instead of pbes. Do you have thoughts on how to overcome that
> > > issue? Are you willing, for example, to do work on switching swsusp to
> > > use a different method of storing its data?
> >
> > Any changes to userspace are a fair game. OTOH kernel provides linear
> > image to be saved to userspace, and what it uses internally should not
> > be important to userland parts. (And Rafael did some changes in that
> > area to make it more effective, IIRC).
>
> Yes.  The code is now split into the part that handles the snapshot image
> (in snapshot.c) and the part that writes/reads it to swap (in swap.c). [I=
'm
> referring to recent -mm kernels.]
>
> The access to the snapshot image is provided via the functions
> snapshot_write_next() and snapshot_read_next() that are called by the
> code in swap.c and may be used by the user space tools via the
> interface in user.c.  In principle it ought to be possible to plug
> something else instead of the code in snapshot.c without
> breaking the rest.

So, what is the answer then? If I submitted patches to provide the possibil=
ity=20
of separating LRU pages into a separate stream of pages to be read/written,=
=20
would it have any chance of getting merged? (Along with other patches to ma=
ke=20
writing a full image of memory possible).

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart17017351.8LNp0xOsml
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD678yN0y+n1M3mo0RAi7UAKDpjjoSr28F326cuBJg9mGW4JMeNgCfUIhX
V7OLCJ24w+9+nVm1tPWxyNU=
=UUAb
-----END PGP SIGNATURE-----

--nextPart17017351.8LNp0xOsml--
