Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWBJAMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWBJAMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWBJAMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:12:01 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:26518 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750812AbWBJAMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:12:00 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Fri, 10 Feb 2006 10:08:25 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602100816.18904.nigel@suspend2.net> <20060209233406.GD3389@elf.ucw.cz>
In-Reply-To: <20060209233406.GD3389@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1768074.PLWWqriCPM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602101008.32368.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1768074.PLWWqriCPM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 10 February 2006 09:34, Pavel Machek wrote:
> Hi!
>
> > > > Any changes to userspace are a fair game. OTOH kernel provides line=
ar
> > > > image to be saved to userspace, and what it uses internally should
> > > > not be important to userland parts. (And Rafael did some changes in
> > > > that area to make it more effective, IIRC).
> > >
> > > Yes.  The code is now split into the part that handles the snapshot
> > > image (in snapshot.c) and the part that writes/reads it to swap (in
> > > swap.c). [I'm referring to recent -mm kernels.]
> > >
> > > The access to the snapshot image is provided via the functions
> > > snapshot_write_next() and snapshot_read_next() that are called by the
> > > code in swap.c and may be used by the user space tools via the
> > > interface in user.c.  In principle it ought to be possible to plug
> > > something else instead of the code in snapshot.c without
> > > breaking the rest.
> >
> > So, what is the answer then? If I submitted patches to provide the
> > possibility of separating LRU pages into a separate stream of pages to =
be
> > read/written, would it have any chance of getting merged? (Along with
> > other patches to make writing a full image of memory possible).
>
> Could we do the other stuff, first, please? Userland
> LZF/encryption/progress should be easy to do, and doing that should
> teach us how to cooperate.

The problem I have with doing that is that it makes more work. Adding suppo=
rt=20
for multiple sets of pages is a more fundamental change, and so should be=20
done earlier. Let me use an analogy from evolutionary theory (yes, I think=
=20
evolution is flawed, but let's ignore that for the mo). If you were trying =
to=20
image the steps by which an amoeba became a human being, would you put the=
=20
devlopment of the cardio-vascular system before the development of eye sigh=
t?=20
Making eye sight work (if it was at all possible) without a cardio vascular=
=20
system would result in a fundamentally different design for the eye than if=
=20
you did the cario-vascular system first. Changing the eye once the=20
cardio-vascular system was in would be a huge redevelopment, and a huge pai=
n.=20
=46or the same reasons, I think that if support for 2 pagesets was going to=
 be=20
put in an implementation it should be done as early as possible. Likewise f=
or=20
reworking the method by which data is stored (I say, thinking of bitmaps vs=
=20
pbes).

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1768074.PLWWqriCPM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD69mAN0y+n1M3mo0RAsxUAKDfBOuv3q2cZG+1HMoNvGk/NfDnYwCgvJt+
SKD24cV54G6j1bCu3s4Y2W8=
=h0nZ
-----END PGP SIGNATURE-----

--nextPart1768074.PLWWqriCPM--
