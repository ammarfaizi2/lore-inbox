Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWBQGCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBQGCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 01:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWBQGCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 01:02:30 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:10918 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932267AbWBQGC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 01:02:29 -0500
Date: Fri, 17 Feb 2006 17:01:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: kyle@parisc-linux.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generic is_compat_task helper
Message-Id: <20060217170129.6a1bbc7a.sfr@canb.auug.org.au>
In-Reply-To: <20060216214939.78aebcbb.akpm@osdl.org>
References: <20060217025242.GM13492@quicksilver.road.mcmartin.ca>
	<20060216214939.78aebcbb.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__17_Feb_2006_17_01_29_+1100_nmtISj_4Jzpy_88J"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__17_Feb_2006_17_01_29_+1100_nmtISj_4Jzpy_88J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Feb 2006 21:49:39 -0800 Andrew Morton <akpm@osdl.org> wrote:
>
> What continues to bug me about this (in a high-level hand-wavy sort of wa=
y)
> is that this is an attribute of the mm_struct, not of the task_struct.

Aren't there really two things here:
	in the syscall path you want to know that the kernel
	was entered through a 32 bit (compat) syscall entry point so
	you know what its arguments are and how to set up its return
	values

	in some places you need to know if the mm is a 32 bit mm

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Feb_2006_17_01_29_+1100_nmtISj_4Jzpy_88J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9Wa5FdBgD/zoJvwRAm6NAJ4kxS+7EL7MjBfpnxENRRR+JbSaQQCdGyTY
iQOPvqMdezQMplSn4FMlMgU=
=0A3x
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Feb_2006_17_01_29_+1100_nmtISj_4Jzpy_88J--
