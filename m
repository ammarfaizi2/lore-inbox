Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWJZCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWJZCTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWJZCTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:32 -0400
Received: from isilmar.linta.de ([213.239.214.66]:40159 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1161062AbWJZCTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:17 -0400
Date: Wed, 25 Oct 2006 22:10:27 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hostap@shmoo.com,
       linville@tuxdriver.com, jkmaline@cc.hut.fi, proski@gnu.org
Subject: [RFC PATCH 0/11] pcmcia: bugfixes for 2.6.19-rc3
Message-ID: <20061026021027.GA20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	hostap@shmoo.com, linville@tuxdriver.com, jkmaline@cc.hut.fi,
	proski@gnu.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The following eleven patches have all been queued in -mm for quite some
time; the only change is that one suggestion by Pavel Roskin (to remove the
"RevA" part of the new ID for hostap_cs.c) is implemented. Please let me
know if there are any objections to any of these patches; if not, I'll
submit them to Linus really soon now.

Thanks,
	Dominik


 drivers/net/wireless/hostap/hostap_cs.c |    7 +++++++
 drivers/pcmcia/at91_cf.c                |   28 +++++++++-------------------
 drivers/pcmcia/au1000_generic.c         |   25 +++++++++++++++++++------
 drivers/pcmcia/ds.c                     |   29 ++++++++++++++++++++++++-----
 drivers/pcmcia/i82092.c                 |    9 +++++----
 drivers/pcmcia/m8xx_pcmcia.c            |   12 ++++++++----
 drivers/pcmcia/omap_cf.c                |    3 ++-
 drivers/pcmcia/pcmcia_ioctl.c           |   11 ++++++++---
 drivers/pcmcia/pcmcia_resource.c        |    2 +-
 drivers/pcmcia/pd6729.c                 |    4 ++++
 drivers/pcmcia/soc_common.c             |    1 +
 drivers/pcmcia/yenta_socket.c           |   22 +++++++++++++++++-----
 12 files changed, 105 insertions(+), 48 deletions(-)
----
Alexey Dobriyan (2):
      CONFIG_PM=n slim: drivers/pcmcia/*
      i82092: wire up errors from pci_register_driver()

Amol Lad (1):
      ioremap balanced with iounmap for drivers/pcmcia

David Brownell (1):
      pcmcia: at91_cf update

Dominik Brodowski (2):
      pcmcia: add more IDs to hostap_cs.c
      PCMCIA: fix __must_check warnings

Jeff Garzik (1):
      PCMCIA: handle sysfs, PCI errors

Jonathan McDowell (1):
      Export soc_common_drv_pcmcia_remove to allow modular PCMCIA.

Kaustav Majumdar (1):
      pcmcia: update alloc_io_space for conflict checking for multifunction PC card

Om Narasimhan (1):
      pcmcia: au1000_generic fix

Randy Dunlap (1):
      pcmcia/ds: driver layer error checking

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQBkSZ8MDCHJbN8YRAhERAKCbHS1CoOqUMwY/LXwIrpWDxcpWlwCgidAd
HwsksV4YKuZ5IzjHdbVyIfI=
=WoOT
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
