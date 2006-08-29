Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWH2RHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWH2RHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWH2RHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:07:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56019 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965123AbWH2RHL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:07:11 -0400
Message-Id: <200608291706.k7TH6ukf003997@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       vnuorval@tcs.hut.fi, davem@davemloft.net
Subject: Re: 2.6.18-rc4-mm3: BUG: warning at include/net/dst.h:154/dst_release()
In-Reply-To: Your message of "Tue, 29 Aug 2006 18:19:36 -0000."
             <20060829181936.GB1633@slug>
From: Valdis.Kletnieks@vt.edu
References: <200608291425.k7TEP7XR004029@turing-police.cc.vt.edu>
            <20060829181936.GB1633@slug>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156871215_3428P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 13:06:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156871215_3428P
Content-Type: text/plain; charset=us-ascii

On Tue, 29 Aug 2006 18:19:36 -0000, Frederik Deweerdt said:
> On Tue, Aug 29, 2006 at 10:25:07AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > Seeing this a lot on 2.6.18-rc4-mm3 with 2 different stack tracebacks
> > (one for received packets, other for sending).  I already picked up the
> > fix for the ^ / confusion in fib_rules.c and that didn't help matters.
> > 
> Hi,
> 
> I'm not familiary with net code, but willing to help :). It looks like
> the fib6_rule_lookup function is increasing dst.__refcnt in one code
> path and not the other. Does the (untested) attached patch help?

Not taking a ref it should is probably a bug, but it doesn't fix the
problem I'm seeing, sorry....

--==_Exmh_1156871215_3428P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE9HQvcC3lWbTT17ARAlZwAKDW4c5cQ1zOe6mALHsX3JEHGFNFPACeJ3Oq
tPp6nqwhmR0UcifdhG9LzhM=
=cx+M
-----END PGP SIGNATURE-----

--==_Exmh_1156871215_3428P--
