Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUHVF0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUHVF0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUHVF0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:26:10 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:51082 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S266198AbUHVF0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:26:04 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 2/2] use hlist for pid hash
Date: Sat, 21 Aug 2004 22:25:51 -0700
User-Agent: KMail/1.7
References: <412824BE.4040801@yahoo.com.au> <4128252E.1080002@yahoo.com.au>
In-Reply-To: <4128252E.1080002@yahoo.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1740015.xUvjn0iEAI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408212225.58536.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1740015.xUvjn0iEAI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 21 August 2004 21:46, you wrote:
> This comes at the "expense" of
> 1. reintroducing the memory  prefetch into the hash traversal loop;
> 2. adding new pids to the head of the list instead of the tail. I
>    suspect that if this was a big problem then the hash isn't sized
>    well or could benefit from moving hot entries to the head.

It looks like the current code is already adding PIDs to the head: list_add=
()=20
adds to the head of a list and list_add_tail() adds to the tail.

=2DRyan

--nextPart1740015.xUvjn0iEAI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKC5mW4yVCW5p+qYRAiSzAKCuz/AI9nFLv+ISWd1lHoiKJUJvIQCfd0Vw
SaQNi+MAYrDTzW890dflUoU=
=dNoB
-----END PGP SIGNATURE-----

--nextPart1740015.xUvjn0iEAI--
