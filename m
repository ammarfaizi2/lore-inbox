Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbUB0Xaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUB0Xaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:30:52 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:8090 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263189AbUB0Xat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:30:49 -0500
Date: Sat, 28 Feb 2004 10:26:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@lst.de, akpm@osdl.org, linus@osdl.org, anton@samba.org,
       paulus@samba.org, axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040228102619.6b844257.sfr@canb.auug.org.au>
In-Reply-To: <20040227134412.A301@infradead.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<20040226095156.GA25423@lst.de>
	<20040227120451.0e3c43bd.sfr@canb.auug.org.au>
	<20040227113202.A31176@infradead.org>
	<20040227225716.5b29c690.sfr@canb.auug.org.au>
	<20040227121300.B31544@infradead.org>
	<20040228002614.2b4ff994.sfr@canb.auug.org.au>
	<20040227133717.GA13381@lst.de>
	<20040227134412.A301@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__28_Feb_2004_10_26_19_+1100_HEjpQhPg/Xivz.bV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__28_Feb_2004_10_26_19_+1100_HEjpQhPg/Xivz.bV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2004 13:44:12 +0000 Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Feb 27, 2004 at 02:37:17PM +0100, Christoph Hellwig wrote:
> > Here's a totally untested patch to fix it up:
> 
> And a better one that makes viodasd_max_disks properly start at 0.

The problem with this approach is that if disk 0 is not configured, the
underlying Hypervisor call will fail and we will never raise the value of
viodasd_max_disk and so we will never probe any of the other disks.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__28_Feb_2004_10_26_19_+1100_HEjpQhPg/Xivz.bV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAP9IgFG47PeJeR58RAiOeAKClhOi0vK+ixR9mZ+ETW+hQc07BcACg3MVP
UGMlNTGhwh927JTOOdrnBlE=
=FQGa
-----END PGP SIGNATURE-----

--Signature=_Sat__28_Feb_2004_10_26_19_+1100_HEjpQhPg/Xivz.bV--
