Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUB0N1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUB0N1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:27:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:24317 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262852AbUB0N0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:26:46 -0500
Date: Sat, 28 Feb 2004 00:26:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, hch@lst.de, akpm@osdl.org, linus@osdl.org,
       anton@samba.org, paulus@samba.org, axboe@suse.de,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040228002614.2b4ff994.sfr@canb.auug.org.au>
In-Reply-To: <20040227121300.B31544@infradead.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<20040226095156.GA25423@lst.de>
	<20040227120451.0e3c43bd.sfr@canb.auug.org.au>
	<20040227113202.A31176@infradead.org>
	<20040227225716.5b29c690.sfr@canb.auug.org.au>
	<20040227121300.B31544@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__28_Feb_2004_00_26_14_+1100_yf=BoPgfuJr_eqyX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__28_Feb_2004_00_26_14_+1100_yf=BoPgfuJr_eqyX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2004 12:13:00 +0000 Christoph Hellwig <hch@infradead.org> wrote:
>
> That's not how I read your code.  But to actually understand what it's
> doing we need to know what open_data.max_disk actually is.
> 
> is this the maximum number of disks currently configured (if so the
> interface would be absolutely braindead, but the current code would
> match your above description although beein rather confusing).

It is the highest index of all the configured disks. Did you read my
previous email?  If disks 1 2 4 and 7 are configured, the
open_data.max_disk will be 7. If the admin thena adds disk 23, the next
time we probe (by calling the HV open interface) the returned max_disk
will be 23.

I do not apologise for braindead interfaces in code I didn't write ...
In this case I just have to use it.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__28_Feb_2004_00_26_14_+1100_yf=BoPgfuJr_eqyX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAP0V2FG47PeJeR58RAogSAKDAZvYOJmI6pskDAXg1VxBkbdURJgCeIN3b
4Q7f8CLLdBhm3DFWLwNq5eQ=
=jQv7
-----END PGP SIGNATURE-----

--Signature=_Sat__28_Feb_2004_00_26_14_+1100_yf=BoPgfuJr_eqyX--
