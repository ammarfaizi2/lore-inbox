Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUJGMc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUJGMc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269763AbUJGMbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:31:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31724 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267324AbUJGMai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:30:38 -0400
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20041007101213.GC10234@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	 <20041005112752.GA21094@logos.cnet>
	 <16739.61314.102521.128577@segfault.boston.redhat.com>
	 <20041006120158.GA8024@logos.cnet>
	 <1097119895.4339.12.camel@orbit.scot.redhat.com>
	 <20041007101213.GC10234@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d7L1I5nHB7ly45dknNWH"
Organization: Red Hat UK
Message-Id: <1097152229.2789.26.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 14:30:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d7L1I5nHB7ly45dknNWH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Now the question is, how strict should the O_NONBLOCK implementation be=20
> in reference to "not blocking" ?

almost any allocation all over the kernel can in theory block ;)
I'd say be pragmatic in this and avoid the obvious pagecache blocking,
but ignore the rest, it'll be rare and if it's there, of short duration.
Userland can get rescheduled anyway at any time for brief periods


--=-d7L1I5nHB7ly45dknNWH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBZTbkpv2rCoFn+CIRAp7eAJ4315aHXa7w4zz/tIonD4BTXM2OawCeMs1t
MGmses3kTAjJJ2NhBeUnaDI=
=3ytp
-----END PGP SIGNATURE-----

--=-d7L1I5nHB7ly45dknNWH--

