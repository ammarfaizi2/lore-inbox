Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUCUAG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbUCUAG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:06:26 -0500
Received: from smtp.golden.net ([199.166.210.31]:53775 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S263573AbUCUAGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:06:24 -0500
Date: Sat, 20 Mar 2004 19:06:19 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Subject: fixmap TLB flushing clarification
Message-ID: <20040321000619.GB14843@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In include/asm-*/fixmap.h the comment about fixed_addresses states:

...
 * these 'compile-time allocated' memory buffers are
 * fixed-size 4k pages. (or larger if used with an increment
 * highger than 1) use fixmap_set(idx,phys) to associate
 * physical memory with fixmap indices.
 *
 * TLB entries of such buffers will not be flushed across
 * task switches.
...

I'm curious about the last statement, is this to mean that a TLB entry will
be reserved at set_fixmap() time in which the translation will happen, and
that particular entry will be locked down for the duration of the mapping?

Is some other convention in place to preserve the translation across a
TLB flush at context switch time, or do we actually need to give up a
TLB entry for each fixmap?


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAXNx71K+teJFxZ9wRAnhBAJ9AO5srPO+LNwiqBTdY2gExbfczowCfcnxH
8+odCP3qYv9/bsImQf8kOeE=
=VlCe
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
