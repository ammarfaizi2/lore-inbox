Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUESU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUESU43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUESU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:56:29 -0400
Received: from facmail.gettysburg.edu ([138.234.4.150]:36511 "EHLO
	facmail.cc.gettysburg.edu") by vger.kernel.org with ESMTP
	id S264571AbUESU4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:56:22 -0400
Date: Wed, 19 May 2004 15:24:14 -0400
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, 2.6.6-rc2 sluggish interrupts
Message-ID: <20040519192414.GA1210@andromeda>
References: <E1BJOXM-0007zu-6H@andromeda> <20040519191900.GA1052@andromeda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20040519191900.GA1052@andromeda>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This also suffices to cease the skipping:

	while true; do false; done;

I also see this, by the way:

	May 19 15:15:51 andromeda kernel: psmouse.c: Mouse at
	isa0060/serio1/input0 lost
	 synchronization, throwing 2 bytes away.
	May 19 15:16:02 andromeda kernel: psmouse.c: Mouse at
	isa0060/serio1/input0 lost
	 synchronization, throwing 1 bytes away.
	May 19 15:16:03 andromeda kernel: psmouse.c: Mouse at
	isa0060/serio1/input0 lost
	 synchronization, throwing 2 bytes away.

But these don't correlate with the skips, which frequently happen even
when there's no kernel log entry for the mouse.  FWIW, that could be a
legitimate hardware problem, though it happens even when I'm using an
external mouse (laptop).

Justin

On Wed, May 19, 2004 at 03:19:00PM -0400, pryzbyj wrote:
> The problem persists with 2.6.6 final, but get this: I was recompiling
> with preempt disabled (which didn't do anything to solve the problem),
> but during the compile, there were very few music skips / mouse skips.
> Not sure what that could mean though..

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq7Reh7yD3l4ITTYRAhC/AKCrDhhdzxDEL39XQxZsv5szrJtjMQCfSGbn
mxP+N5ilq1MpA/StpUlA3i8=
=9EXq
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
