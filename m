Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVIWHKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVIWHKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIWHKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:10:04 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:51942 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750708AbVIWHKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:10:03 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: making kmalloc BUG() might not be a good idea
Date: Fri, 23 Sep 2005 09:09:47 +0200
User-Agent: KMail/1.7.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, clameter@engr.sgi.com
References: <20050922.231434.07643075.davem@davemloft.net> <4333A109.2000908@yahoo.com.au>
In-Reply-To: <4333A109.2000908@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4633142.lWGBWvbvRP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509230909.54046.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4633142.lWGBWvbvRP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday 23 September 2005 08:30, Nick Piggin wrote:
> David S. Miller wrote:
> >I'm sort-of concerned about this change:
> >
> >    [PATCH] __kmalloc: Generate BUG if size requested is too large.
> >
> >it opens a can of worms, and stuff that used to generate
> >-ENOMEM kinds of failures will now BUG() the kernel.
> Making it WARN might be a good compromise.

Which has the potential to spam the logs with a user triggerable event
without even killing the responsible process.
Same problem, just worse.

I could live with a solution that enables it based on a config.

KERNEL_HACKING is no such config. That feature is almost always
enabled, because MAGIC_SYSRQ depends on it and a significant amount
of Linux-Admins like it for a "sync, remount ro and reboot" sequence.
So you need a new one.


Regards

Ingo Oeser



--nextPart4633142.lWGBWvbvRP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDM6pBU56oYWuOrkARAmrhAKC4Xi5EK7EGpWUEO1hO6711MP190ACgnybZ
v0O5DMcPIcabUMzOIjRs0LY=
=+Lot
-----END PGP SIGNATURE-----

--nextPart4633142.lWGBWvbvRP--
