Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUF0FgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUF0FgG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 01:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUF0FgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 01:36:06 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:60108 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266274AbUF0Ff5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 01:35:57 -0400
Date: Sat, 26 Jun 2004 22:35:45 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       david-b@pacbell.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
Message-ID: <20040627053545.GE10113@one-eyed-alien.net>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
	arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	oliver@neukum.org
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <Pine.LNX.4.44L0.0406262356110.30028-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0406262356110.30028-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 27, 2004 at 12:05:22AM -0400, Alan Stern wrote:
> On Sat, 26 Jun 2004, Pete Zaitcev wrote:
> > The current usb-storage works quite well on servers where netdump can
> > be brought to bear, but on desktop its debuggability leaves some room
> > for improvement.
>=20
> I agree that the debug logging in usb-storage is not good.  A worthwhile
> improvement would be to log only commands that fail or get an error, with
> the logging selected by the normal USB debugging (not usb-storage verbose
> debugging) configuration option.  Matt, what do you think?

This is an acknowledged weak point of usb-storage.

A 'log only on error' system might be good... but it's going to be a bit
tricky for two reasons:

1) We have to keep data around longer than currently, so we can log it if
something goes wrong later (so we see how we got to this point).

2) What counts as an error?  We probably only want this to kick in when the
SCSI error-recovery does.  Normal 'failed commands' probably shouldn't
count.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I want my GPFs!!!
					-- Stef
User Friendly, 11/9/1998

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA3lyxIjReC7bSPZARAjByAJ9j+JZ6jfYlXlr1cu3V4WgPUiG7TwCgzruR
ZEJzeU175mpF3gi2FVmSJuw=
=iklP
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
