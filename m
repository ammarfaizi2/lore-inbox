Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUHXTig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUHXTig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbUHXTig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:38:36 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:46976 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S268240AbUHXTib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:38:31 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] ioport-cache-2.6.8.1.patch
Date: Tue, 24 Aug 2004 12:38:26 -0700
User-Agent: KMail/1.7
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com> <20040824071928.GA7697@elte.hu>
In-Reply-To: <20040824071928.GA7697@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2336687.ZfKeHfAi8o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408241238.29702.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2336687.ZfKeHfAi8o
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 24 August 2004 00:19, you wrote:
> +=A0=A0=A0=A0=A0=A0=A0if (likely(next =3D=3D tss->io_bitmap_owner)) {

Probably a stupid question, but what's stopping the tss->io_bitmap_owner fr=
om=20
being killed, and then a new thread_struct being kmalloc()'ed in the exact=
=20
same place as the old one? I realize it's highly unlikely, I'm just wonderi=
ng=20
if it's possible at all.

I guess clearing tss->io_bitmap_owner whenever we kfree() the bitmap owner'=
s=20
thread_struct would plug that up.

=2DRyan

--nextPart2336687.ZfKeHfAi8o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBK5k1W4yVCW5p+qYRAhO4AJ0ZFrtmZhgwPZVj3UavXtZZUI/7CgCeMSZX
yrX9gzVUcjSspXvfY5/+YFQ=
=GE3/
-----END PGP SIGNATURE-----

--nextPart2336687.ZfKeHfAi8o--
