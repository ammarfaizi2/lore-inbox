Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbUAXS0e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266987AbUAXS0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:26:34 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:16516 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S266985AbUAXS0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:26:31 -0500
Subject: Re: Request: I/O request recording
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040124181026.GA22100@codeblau.de>
References: <20040124181026.GA22100@codeblau.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6wy1vJSrLmYZb8FOxHGY"
Organization: Red Hat, Inc.
Message-Id: <1074968776.4442.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 24 Jan 2004 19:26:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6wy1vJSrLmYZb8FOxHGY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-24 at 19:10, Felix von Leitner wrote:
> I would like to have a user space program that I could run while I cold
> start KDE.  The program would then record which I/O pages were read in
> which order.  The output of that program could then be used to pre-cache
> all those pages, but in an order that reduces disk head movement.
> Demand Loading unfortunately produces lots of random page I/O scattered
> all over the disk.

I recently did something like this (and it scared me, it seems a typical
Fedora boot into gnome opens like 11.000 files ;) but via a printk in
the kernel....

I experimented with readahead'ing all that stuff while the initscripts
ran in the hope it would save time... but it doesn't somehow.

Some other things kinda help; if you feel adventurous you could play
with the kernel-utils RPM in rawhide which does a readahead of the files
the desktop opens while GDM login window is displayed; if the user isn't
typing his name really fast that decreases the desktop startup time...

--=-6wy1vJSrLmYZb8FOxHGY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAErjIxULwo51rQBIRAj/3AJ9ccZ+hT4DpVgYNFQF8gEigjxMesgCeOITe
VS9fnix6gEAxL+G6zPdQJRc=
=1nhp
-----END PGP SIGNATURE-----

--=-6wy1vJSrLmYZb8FOxHGY--
