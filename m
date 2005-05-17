Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVEQSBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVEQSBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEQSBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:01:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1808 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261874AbVEQSBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:01:31 -0400
Message-Id: <200505171801.j4HI1TWC023029@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502 
In-Reply-To: Your message of "Tue, 17 May 2005 09:55:28 PDT."
             <20050517165528.GB27549@shell0.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
            <20050517165528.GB27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116352889_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 14:01:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116352889_5349P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 09:55:28 PDT, Chris Wright said:
> * Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> > It threw 5 of them in short succession.  Different entry points into
> > avc_has_perm(). Here's the tracebacks:
> 
> I'm guessing this is from my change to use single skb for audit buffer
> instead of a temp buffer.
> 
> > [4295584.974000] Debug: sleeping function called from invalid context at mm/slab.c:2502
> > [4295584.974000] in_atomic():1, irqs_disabled():0
> 
> This is gfp_any() flag that's used here, which I think is the problem.

I'll be more than happy to test any patches...


--==_Exmh_1116352889_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCijF5cC3lWbTT17ARAt0jAKDc++0MTAe1XIALi+ypoPq2WqST1QCgikQP
HudY+5Ri4Wd4ID4KcBvKIZs=
=y+cu
-----END PGP SIGNATURE-----

--==_Exmh_1116352889_5349P--
