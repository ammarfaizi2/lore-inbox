Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266515AbUFQPQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266515AbUFQPQL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUFQPQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:16:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266537AbUFQPPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:15:17 -0400
Subject: Re: PATCH: Further aacraid work
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040617145808.GA29938@devserv.devel.redhat.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com>
	 <1087484107.2090.42.camel@mulgrave>
	 <20040617145808.GA29938@devserv.devel.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7kMR3E+EDJK6j55MRO+3"
Organization: Red Hat UK
Message-Id: <1087485308.2711.36.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Jun 2004 17:15:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7kMR3E+EDJK6j55MRO+3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-17 at 16:58, Alan Cox wrote:
> On Thu, Jun 17, 2004 at 09:55:03AM -0500, James Bottomley wrote:
> > This is hardly a big problem, is it?  it only occurs during the first
> > few moments of system operation.  After that, the pages assigned to a
> > virtual region are pretty much random.
>=20
> When I looked at it (which I grant was 2.2 and 2.4 the pattern was
> visible on machines that had been running for a week or more)

probably because of the buddy grouping/ungrouping;

--- linux-2.6.7/mm/page_alloc.c~        2004-06-17 17:13:58.830727762
+0200
+++ linux-2.6.7/mm/page_alloc.c 2004-06-17 17:13:58.831727642 +0200
@@ -301,7 +301,7 @@ expand(struct zone *zone, struct page *p
                area--;
                high--;
                size >>=3D 1;
-               list_add(&page->lru, &area->free_list);
+               list_add_tail(&page->lru, &area->free_list);
                MARK_USED(index, high, area);
                index +=3D size;
                page +=3D size;


--=-7kMR3E+EDJK6j55MRO+3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0bV8xULwo51rQBIRAlEXAJ42eG+Gu/xC7eCaz+ydWcIbIaOCNQCghDRJ
Fx50hqcw28JVXv4sbODenDM=
=dnLU
-----END PGP SIGNATURE-----

--=-7kMR3E+EDJK6j55MRO+3--

