Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWFNJkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWFNJkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFNJkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:40:07 -0400
Received: from ex001a.cxnet.dk ([195.135.216.13]:51107 "EHLO
	comxexch01.comx.local") by vger.kernel.org with ESMTP
	id S932236AbWFNJkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:40:05 -0400
Subject: [PATCH 0/2] NET: Accurate packet scheduling for ATM/ADSL
From: Jesper Dangaard Brouer <hawk@comx.dk>
To: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       lartc@mailman.ds9a.nl
Cc: russell-tcatm@stuart.id.au, hawk@comx.dk, hawk@diku.dk,
       linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ceiKuguFA1mulwiJNlSr"
Organization: ComX Networks A/S
Date: Wed, 14 Jun 2006 11:40:04 +0200
Message-Id: <1150278004.26181.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 14 Jun 2006 09:40:04.0329 (UTC) FILETIME=[83A76590:01C68F96]
X-TM-AS-Product-Ver: SMEX-7.0.0.1345-3.52.1006-14506.002
X-TM-AS-Result: No--0.350000-8.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ceiKuguFA1mulwiJNlSr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The Linux traffic's control engine inaccurately calculates
transmission times for packets sent over ADSL links.  For
some packet sizes the error rises to over 50%.  This occurs
because ADSL uses ATM as its link layer transport, and ATM
transmits packets in fixed sized 53 byte cells.

The following patches to iproute2 and the kernel add an
option to calculate traffic transmission times over all
ATM links, including ADSL, with perfect accuracy.

A longer presentation of the patch, its rational, what it
does and how to use it can be found here:
   http://www.stuart.id.au/russell/files/tc/tc-atm/

A earlier version of the patch, and a _detailed_ empirical
investigation of its effects can be found here:
   http://www.adsl-optimizer.dk/

The patches are both backwards and forwards compatible.
This means unpatched kernels will work with a patched
version of iproute2, and an unpatched iproute2 will work
on patches kernels.


This is a combined effort of Jesper Brouer and Russell Stuart,
to get these patches into the upstream kernel.

Let the discussion start about what we need to change to get this
upstream?

We see this as a feature enhancement, as thus hope that it can be
queued in davem's net-2.6.18.git tree.

---
Regards,
 Jesper Brouer & Russell Stuart.


--=-ceiKuguFA1mulwiJNlSr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEj9l0wuVH+NB3fZkRAjFIAJsE+rSjWJ587fSIu1SHQ1i0Zt0MMACffcwN
nO3YofocOeRchTH1h4F0mXI=
=6KRJ
-----END PGP SIGNATURE-----

--=-ceiKuguFA1mulwiJNlSr--

