Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUIOPWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUIOPWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIOPWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:22:00 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:62930 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266295AbUIOPV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:21:57 -0400
Date: Wed, 15 Sep 2004 17:20:19 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Ian Campbell <icampbell@arcom.com>
Cc: "Giacomo A. Catenazzi" <cate@debian.org>, Greg KH <greg@kroah.com>,
       "Marco d'Itri" <md@Linux.IT>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Message-ID: <20040915152019.GD24818@thundrix.ch>
References: <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org> <1095258966.18800.34.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <1095258966.18800.34.camel@icampbell-debian>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 15, 2004 at 03:36:06PM +0100, Ian Campbell wrote:
> I wonder if it would be feasible for modprobe (or some other utility) to
> have a new option: --wait-for=/dev/something which would wait for the
> device node to appear. Perhaps by:
> 	- some mechanism based on HAL, DBUS, whatever
> 	- dnotify on /dev/?
> 	- falling back to spinning and waiting.

This would  end up  as hideous misfeature  as you can't  guarantee the
device to show up *at* *all*.

The reason udev is there is that we can dynamically respond to created
device nodes and  devices that show up. They  might have changed since
the last boot. Maybe they don't show up at all.

Thus you should trigger your actions from /etc/dev.d.

			    Tonnerre


--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBSF2y/4bL7ovhw40RAjLuAKCjXQJ7GweUwG85xQufb2IyYsNwEgCgmOdd
clzNrcOeiBzQy0HaOyPZSFA=
=SFdQ
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
