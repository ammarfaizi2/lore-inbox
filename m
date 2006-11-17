Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424805AbWKQPif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424805AbWKQPif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424796AbWKQPif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:38:35 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:24784 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1424805AbWKQPie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:38:34 -0500
Date: Fri, 17 Nov 2006 10:41:19 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Christian Hoffmann <chrmhoffmann@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061117154119.GC5158@shaftnet.org>
Mail-Followup-To: Christian Hoffmann <chrmhoffmann@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <1163555308.5940.177.camel@localhost.localdomain> <200611151109.06956.rjw@sisk.pl> <200611162317.30880.chrmhoffmann@gmail.com> <20061117060758.GB25413@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20061117060758.GB25413@shaftnet.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Fri, 17 Nov 2006 10:41:21 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2006 at 01:07:58AM -0500, Stuffed Crust wrote:
>   http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP1.diff

 http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v7-WIP2.diff

This incorporates the latest round of BenH's fixes and changes, but=20
backs out the PCI suspend changes, which need independent review and testin=
g. =20

(BenH has promised a little more work before he's ready to sign off,=20
 hence the -WIP2 designation)

The following patch contains a rewrite of radeonfb's suspend/resume code=20
to use standard PCI subsystem calls.  It applies to 2.6.19-rc6 and also=20
on top of the v7-WIP2 patch.

 http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-suspend.diff

Christian, if you could see if the latter patch (on top of the -v6b or=20
-WIP2 patches) makes a difference for your suspend/resume problems..

And with these patches, I'm going to drop offline for a camping trip=20
over the weekend.  I'll pick this stuff back up on Monday.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFXdgfPuLgii2759ARAtSnAKDLVuyrsoNUwJGrqXJypsG3QUQqvwCfc+z1
Bhp57NngZh0EmG9N/RPmf2U=
=VpPC
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
