Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVJVSY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVJVSY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 14:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJVSY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 14:24:29 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:36820 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751080AbVJVSY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 14:24:28 -0400
Date: Sat, 22 Oct 2005 21:24:27 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] mm: i386 sh sh64 ready for split ptlock
Message-ID: <20051022182427.GA22045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221718100.18047@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510221718100.18047@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 22, 2005 at 05:19:30PM +0100, Hugh Dickins wrote:
> The sh __do_page_fault: which handles both kernel faults (without lock)
> and user mm faults (locked - though it set_pte without locking before).
>=20
> The sh64 flush_cache_range and helpers: which wrongly thought callers
> held page_table_lock before (only its tlb_start_vma did, and no longer
> does so); moved the flush loop down, and adjusted the large versus small
> range decision to consider a range which spans page tables as large.
>=20
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Yes, that was very clearly broken, thanks for noting this.

I won't be able to test the sh64 bits until later this week, but both
of these changes look good to me. I'll take care of cleaning up any
breakage this introduces, thanks Hugh.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDWoPb1K+teJFxZ9wRAmuRAJ93ZStwE8oee0ay6cRyRwAvhXrXwgCfaaSG
ptxT0yTZt/AgklfHlgjj9hY=
=JzLt
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
