Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVDIIcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDIIcH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDIIcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:32:07 -0400
Received: from smtpout16.mailhost.ntl.com ([212.250.162.16]:48934 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261314AbVDIIcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:32:01 -0400
Subject: Re: [PATCH] Add TPM hardware enablement driver
From: Ian Campbell <ijc@hellion.org.uk>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1112990855.4573.4.camel@dyn95395164>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
	 <Pine.LNX.4.61.0503161811020.5212@jo.austin.ibm.com>
	 <4240CE30.2060105@pobox.com> <20050324063933.GC10355@kroah.com>
	 <42432B59.70003@pobox.com>  <20050324213302.GA26729@kroah.com>
	 <1112717690.7713.23.camel@jo.austin.ibm.com>
	 <1112990855.4573.4.camel@dyn95395164>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HIktf2RqpyUas0JQHGz/"
Date: Sat, 09 Apr 2005 09:31:54 +0100
Message-Id: <1113035520.4476.7.camel@cthulhu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HIktf2RqpyUas0JQHGz/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 15:07 -0500, Kylene Jo Hall wrote:

> Basically, what I need to figure out is how to solve both issues
> simultaneously.  I need to not register a pci_driver as I would be
> taking over an ID that is not unique to my device as well as get the
> hotplugging correct (which i don't know how to do with out a pci_remove
> function).

Perhaps it makes sense to create a new lpc subsystem with an lpc bus
type. Then the PCI driver would register a new lpc bus and LPC device
drivers would register themselves with that. Or if the LPC is
independent of any PCI device the LPC "bridge" driver would just be
another driver to be loaded.

It sounds like it might end up similar to the i2c subsystem for example.

Ian.
--=20
Ian Campbell

Every time I think I know where it's at, they move it.

--=-HIktf2RqpyUas0JQHGz/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCV5L6M0+0qS9rzVkRAienAKCrIw1IYTT4vbBhmSsTyfZauvLjaACgx2ac
mQzU51J7abqv58LupaVmEZg=
=oG++
-----END PGP SIGNATURE-----

--=-HIktf2RqpyUas0JQHGz/--

