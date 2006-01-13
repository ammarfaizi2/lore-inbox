Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWAMSqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWAMSqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWAMSqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:46:55 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:42695 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1422815AbWAMSqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:46:54 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
Date: Fri, 13 Jan 2006 19:46:38 +0100
User-Agent: KMail/1.7.2
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       " Greg Kroah-Hartman " <gregkh@suse.de>
References: <20060113032102.154909000@sorel.sous-sol.org> <20060113032238.565599000@sorel.sous-sol.org>
In-Reply-To: <20060113032238.565599000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1617438.thaB3x3XbN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601131946.46782.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1617438.thaB3x3XbN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

On Friday 13 January 2006 03:37, Chris Wright wrote:
> One of the conversions from memcmp to compare_ether_addr is incorrect.
> We need to do relative comparison to determine min MAC address to
> use in bridge id. This will cause the wrong bridge id to be chosen
> which violates 802.1d Spanning Tree Protocol, and may create forwarding
> loops.

Why not include a shorter version of this nice explanation
above the list_for_each_entry() loop?

Like:

/* We try to find the min MAC address to use in this bridge id. */

This will prevent the next janitor from converting this again
which avoids future regressions here.

What do you think?


Regards

Ingo Oeser


--nextPart1617438.thaB3x3XbN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx/WWU56oYWuOrkARAtLtAKCnvQkhneBTnp5+X7EfO7Fk8/2jKgCgvQnM
QHFkxWwUvBDkROhCWimS4tY=
=swiH
-----END PGP SIGNATURE-----

--nextPart1617438.thaB3x3XbN--
