Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWJDPsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWJDPsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWJDPsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:48:05 -0400
Received: from systemlinux.org ([83.151.29.59]:39597 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1161247AbWJDPsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:48:02 -0400
Date: Wed, 4 Oct 2006 17:42:27 +0200
From: Andre Noll <maan@systemlinux.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       riel@redhat.com
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061004154227.GD22487@skl-net.de>
References: <20061004104018.GB22487@skl-net.de> <4523BE45.5050205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <4523BE45.5050205@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23:59, Nick Piggin wrote:

> Ah, this old thing. I hope it is repeatable?

Well, it happened on both of the new machines we got last week. One
of these is still up BTW and I'm able to ssh into it.

> What we really want is the bit before this, the "Eeek! page_mapcount went
> negative" part.

There's no such message in the log. The preceeding lines are just normal
startup messages:

	Adding 16779852k swap on /dev/sda1.  Priority:42 extents:1 across:16779852k
	Adding 16779852k swap on /dev/sdb1.  Priority:42 extents:1 across:16779852k
	process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT

> It is also nice if we can work out where the page actually came from. The
> following attached patch should help out a bit with that, if you could
> run with it?

Okay. I'll reboot with your patch and let you know if it crashes again.

Thanks for the quick response.
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFI9ZjWto1QDEAkw8RAoYvAKCNCPsMxYj0zqgOfpVGSrf6k8/qDACeNyBy
a4j6F6rh6OhdW4AlYBKZ6GE=
=k5xE
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
