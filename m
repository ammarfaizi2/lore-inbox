Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFCWr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTFCWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:47:58 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:3597 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261757AbTFCWr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:47:56 -0400
Date: Tue, 3 Jun 2003 16:01:17 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jocelyn Mayer <jma@netgem.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-ID: <20030603160117.D21083@one-eyed-alien.net>
Mail-Followup-To: Jocelyn Mayer <jma@netgem.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> <20030602163443.2bd531fb.georgn@somanetworks.com> <1054588832.4967.77.camel@jma1.dev.netgem.com> <20030603113636.GX10102@phunnypharm.org> <1054663917.4967.99.camel@jma1.dev.netgem.com> <20030603185421.GB10102@phunnypharm.org> <1054671619.4951.139.camel@jma1.dev.netgem.com> <20030603132504.C21083@one-eyed-alien.net> <1054674754.4951.184.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1054674754.4951.184.camel@jma1.dev.netgem.com>; from jma@netgem.com on Tue, Jun 03, 2003 at 11:12:34PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2003 at 11:12:34PM +0200, Jocelyn Mayer wrote:
> On Tue, 2003-06-03 at 22:25, Matthew Dharm wrote:
> > I know jumping in the middle of a conversation is bad, but....
> >=20
> > In conversations with the SBP2 folks, they indicated to me that the way
> > they do hotplugging is very different from the way usb-storage does it.
> > The end result (I'm told) is that invoking a scan from userspace is oft=
en
> > needed for SBP2 but never for usb-storage.
> >=20
> > So, comparing the two is really pointless.
>=20
> you're right, I just wanted to point that there's no reason
> that we need to register a device etheir by hand or using
> an "infamous script" (citation from Ben Collins
> http://sourceforge.net/mailarchive/message.php?msg_id=3D4435485 )
> due to the SCSI stack, but that it's only a SBP2 problem.

Actually, it is/was a SCSI problem.  The short version being that it is/was
easier to hotplug an entire HBA rather than an individual device.  That is
being changed in 2.5 right now.  usb-storage used an HBA-per-device, while
SBP2 uses a single HBA.

Of course, all this is being changed right now in 2.5.x

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's monday.  It must be monday.
					-- Greg
User Friendly, 5/4/1998

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+3Si9IjReC7bSPZARAuhfAJ47EaH7ia4FVN+zJFpSeL8sUfHHVACfWvyD
lwZsfedyNiq0wpP6JNzacgE=
=euTK
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
