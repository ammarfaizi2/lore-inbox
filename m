Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbULFA37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbULFA37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULFA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:29:59 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:8435 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261433AbULFA35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:29:57 -0500
Date: Sun, 05 Dec 2004 19:29:54 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH] Time sliced CFQ #2
In-reply-to: <20041205185844.GF6430@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <20041206002954.GA28205@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=y0ulUmNC+osPPQO6;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <20041204104921.GC10449@suse.de>
 <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 05, 2004 at 07:58:45PM +0100, Jens Axboe wrote:
> It should be really easy to try some rudimentary prio io support - just
> scale the time slice based on process priority. A few lines of code
> change, and io priority now follows process cpu scheduler priority. To
> work really well, the code probably needs a few more limits besides just
> slice time.

I started working on the rudimentary io prio code, and it got me thinking...
Why use the cpu scheduler priorities? Wouldn't it make more sense to add
io_prio to task_struct? This way you can have a process which you know needs
a lot of CPU but not as much io, or the other way around.

What do you think?

Jeff.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBs6gCwFP0+seVj/4RAkZ4AKCrvaK8CdT/k9ctAMPD7R0FRY/uagCeKdP6
pfJHW3/4uYKg4hImEjaTilk=
=98UG
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
