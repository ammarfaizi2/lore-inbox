Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUBPJfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 04:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUBPJfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 04:35:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45778 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265470AbUBPJfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 04:35:09 -0500
Date: Mon, 16 Feb 2004 10:35:04 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Joe Thornber <thornber@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: dm core patches
Message-ID: <20040216093504.GE21409@devserv.devel.redhat.com>
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti> <20040213151213.GR21298@marowsky-bree.de> <20040213153936.GF15736@reti> <1076688539.4441.2.camel@laptop.fenrus.com> <20040216081945.GF20998@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20040216081945.GF20998@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 16, 2004 at 09:19:45AM +0100, Lars Marowsky-Bree wrote:
> On 2004-02-13T17:08:59,
>    Arjan van de Ven <arjanv@redhat.com> said:
> 
> > one thing you can do is provide a way for drivers to wake the userspace
> > tester early. Say by default it polls every minute, but if the fiber
> > channel driver gets a LIP UP event it (via a central API) makes the
> > userspace daemon *now*.
> 
> I may be missing something obvious, but a LIP UP should be accompanied
> with a round of 'device detections' on that link, which already should
> trigger a few hotplug events, no?
> 
> So this seems pretty much solved.

not normaly; there are several reasons the loop can bounce briefly and right
now the fiber drivers don't notify linux of that every time. Maybe that's
for the better .... if it's a frequent thing that is short-timed then it
would be obscene to yank the disks from under the user (and force-umount his
fs) every few hours..

while in multipath you do want to at least stop using the current path if
there is another path that is not in negotiation...

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAMI7HxULwo51rQBIRApcTAJwNb3dZB3oPg5zBg/+jMAiU6hWbSQCeOpLo
nGsCuGsti0McQuZ3w4BXuus=
=XsR4
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
