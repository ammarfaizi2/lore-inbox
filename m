Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbUKOWzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUKOWzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKOWxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:53:37 -0500
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:16789 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S261509AbUKOWvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:51:23 -0500
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Sami Farin <7atbggg02@sneakemail.com>
Subject: Re: vm-pageout-throttling.patch: hanging in throttle_vm_writeout/blk_congestion_wait
Date: Mon, 15 Nov 2004 14:51:19 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041115012620.GA5750@m.safari.iki.fi> <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain> <20041115223709.GD6654@m.safari.iki.fi>
In-Reply-To: <20041115223709.GD6654@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1230411.UrjID7IX2L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411151451.21671.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1230411.UrjID7IX2L
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 15 November 2004 14:37, Sami Farin wrote:
> I know it's a "nicer" idea to use some partition for the swap
> instead of a file on reiserfs, but I created too small swap partitions
> originally and I can't(/bother?) resize the other partitions.
> And sometimes some memhog forces me to add even more swap.

He's not suggesting you use a swap partition; he's suggesting you swapon th=
e=20
file directly without using the loopback device, ie:

swapon /path/to/file/on/reiserfs

This allows the kernel to perform certain optimizations and removes the=20
overhead of the loopback device.

=2DRyan

--nextPart1230411.UrjID7IX2L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBmTLpW4yVCW5p+qYRAovEAJ90ntUCjwKQfLofi8WBnr2tfecyPgCgt2je
xAksRUJ61JPYu3o5Cn3bLHc=
=64L1
-----END PGP SIGNATURE-----

--nextPart1230411.UrjID7IX2L--
