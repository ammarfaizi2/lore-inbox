Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUEFMwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUEFMwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUEFMv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:51:28 -0400
Received: from lists.us.dell.com ([143.166.224.162]:36439 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262085AbUEFMvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:51:10 -0400
Date: Thu, 6 May 2004 07:46:49 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Sourav Sen <souravs@india.hp.com>
Cc: matthew.e.tolentino@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506124649.GA13482@lists.us.dell.com>
References: <003801c43347$812a1590$39624c0f@india.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <003801c43347$812a1590$39624c0f@india.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
> The following simple patch creates a read-only file
> "memmap" under <mount point>/firmware/efi/ in sysfs
> and exposes the efi memory map thru it.

I'm not generally opposed, but have a couple questions.

1) Why does userspace / humans need to know this?  For debugging firmware?

2) Can the memory map output ever be larger than PAGE_SIZE (lower
limit is 4KB on x86)?  If not, what guarantees that?  If so, you need
your own read mechanism rather than the generic sysfs one.

The one-value-per-file rule has an exception for an array of values of
the same type per Documentation/filesystems/sysfs.txt, which this
looks to adhere to.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAmjO4Iavu95Lw/AkRAoxxAJ99zD9QmdRbNgIsPvXhDlkv1Pd1wACgmy+J
xAUZX4bT/l6iKB2IASkd6To=
=hG3g
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
