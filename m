Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbUK3Urj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbUK3Urj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUK3Uri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:47:38 -0500
Received: from grendel.firewall.com ([66.28.58.176]:36565 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262309AbUK3UrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:47:10 -0500
Date: Tue, 30 Nov 2004 21:47:08 +0100
From: Marek Habersack <grendel@caudium.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: user- vs kernel-level resource sandbox for Linux?
Message-ID: <20041130204708.GB14080@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20041129101919.GB9419@beowulf.thanes.org> <200411292000.iATK0qOF004026@ccure.user-mode-linux.org> <16811.40687.892939.304185@wombat.chubb.wattle.id.au> <20041130023947.GI5378@beowulf.thanes.org> <1101840505.25628.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <1101840505.25628.105.camel@localhost.localdomain>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2004 at 06:48:27PM +0000, Alan Cox scribbled:
> On Maw, 2004-11-30 at 02:39, Marek Habersack wrote:
> > per-process isn't enough. I specifically need something to limit the me=
mory
> > usage on a more global scale - per user ID or per process group or a si=
milar
> > way of grouping related processes. That's the only way to tame processes
> > like apache. At this point the option I'm considering is Xen, unless I =
can
> > find a userland solution to the problem...
>=20
> I'd suggest playing with Xen - its very efficient and it really does
> come close to perfect constraint for resources.
That's my current impression. I also considered writing a simple kernel
module to intercept sys_brk, but that seemed to be a bit clumsy. We have
been running a test installation of Xen with 2 VMs under quite high load and
it performs outstandingly well in "laboratory environment".
Also, I seem to recall there used to be a patch for the linux kernel to imp=
lement=20
BSD-like jail environment, which would suit my purpose too, do you know wha=
t happened
to the project/where it can be found? It would be a great addition to the
kernel, just like the Zones in Solaris 10 are (which are based on the BSD
jail concept as well).

regards,

marek

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBrNxMq3909GIf5uoRAvS0AJ0YUeqXlhcd5eqhPBnOS74tPYTGnwCfZ8xP
y5B0ryX00UlZ6E+Uk4b6B8E=
=yNNG
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
