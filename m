Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUKIHmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUKIHmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUKIHmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:42:37 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:34722 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261410AbUKIHm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:42:29 -0500
Date: Tue, 9 Nov 2004 18:42:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [0/6] PPC64 iSeries Machine Facilities code cleanup
Message-Id: <20041109184223.16ea3414.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_18_42_23_+1100_FMoVAgKnW0Mgr1fP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_18_42_23_+1100_FMoVAgKnW0Mgr1fP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

The following patches clean up iSeries_mf.c and related files.  There are
a couple of simple fixes in here, but mainly this is just reorganisation
and tidying.  (Lots of Studly Caps disappear!)

The overall diffstat looks like this:

 arch/ppc64/kernel/Makefile        |    2
 arch/ppc64/kernel/iSeries_pci.c   |    6
 arch/ppc64/kernel/iSeries_setup.c |    9
 arch/ppc64/kernel/mf.c            | 1118 +++++++++++++++++++++-----------------
 arch/ppc64/kernel/mf_proc.c       |  250 --------
 arch/ppc64/kernel/rtc.c           |    4
 arch/ppc64/kernel/viopath.c       |    4
 drivers/net/iseries_veth.c        |    6
 include/asm-ppc64/iSeries/mf.h    |   41 -
 9 files changed, 668 insertions(+), 772 deletions(-)

Please apply them all (in order) and send to Linus.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__9_Nov_2004_18_42_23_+1100_FMoVAgKnW0Mgr1fP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHTf4CJfqux9a+8RAgNdAJ9PHn7x0t86dg07HA0D6I9VcGiOVgCgl47j
hcml9xDVUCgiOVJQciNveFY=
=VnCC
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_18_42_23_+1100_FMoVAgKnW0Mgr1fP--
