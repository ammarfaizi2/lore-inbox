Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUIQVyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUIQVyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 17:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIQVyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 17:54:11 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:26765 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269022AbUIQVyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 17:54:04 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Andrea Arcangeli <andrea@novell.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 14:54:00 -0700
User-Agent: KMail/1.7
Cc: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040917154834.GA3180@crusoe.alcove-fr> <20040917205011.GA3049@crusoe.dsnet> <20040917212847.GC15426@dualathlon.random>
In-Reply-To: <20040917212847.GC15426@dualathlon.random>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4132376.HK5uhr8d1b";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409171454.02531.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4132376.HK5uhr8d1b
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 17 September 2004 14:28, Andrea Arcangeli wrote:
> I also wonder if a O(1) algorithm exists to roundup to the next power of
> two (doesn't come to mind by memory, hmm maybe it's not that easy
> problem).

Assuming that the architecture has an O(1) fls() function, this should work=
=20
for non-zero values:

inline unsigned int roundup(unsigned int x)
{
 return (1 << fls(x));
}

=2DRyan

--nextPart4132376.HK5uhr8d1b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBS1z6W4yVCW5p+qYRAqyqAJ4o/1z7ICvM3xQQssNG/tuZ4cpdWwCfbR9L
00f0h380Us3aFbXWESHhpBk=
=cU9a
-----END PGP SIGNATURE-----

--nextPart4132376.HK5uhr8d1b--
