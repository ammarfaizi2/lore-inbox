Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264837AbUEKQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbUEKQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUEKQ2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:28:19 -0400
Received: from ns.suse.de ([195.135.220.2]:43675 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264827AbUEKQ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:26:42 -0400
Date: Tue, 11 May 2004 18:26:38 +0200
From: Kurt Garloff <garloff@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Format Unit can take many hours
Message-ID: <20040511162638.GU4828@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040511114936.GI4828@tpkurt.garloff.de> <20040511122037.GG1906@suse.de> <40A0FAE9.90900@pobox.com> <20040511161427.GW1906@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIMVlEQ///Q2JYC7"
Content-Disposition: inline
In-Reply-To: <20040511161427.GW1906@suse.de>
X-Operating-System: Linux 2.6.5-9-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oIMVlEQ///Q2JYC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 11, 2004 at 06:14:27PM +0200, Jens Axboe wrote:
> On Tue, May 11 2004, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > >block/scsi_ioctl.c should likely receive similar treatment then.
> >=20
> > This timeout is dependent on media size, I should think...
> >=20
> > Is there any reason to think that this timeout will _not_ be continuall=
y=20
> > patched in the future, as larger and larger sizes are used?

The disks gets faster as well.

But if we have to touch it every three years, I don't see this as a=20
huge problem either. If you want some more room, you can set it to=20
24hrs now ...

> I think the timeout is only used for ancient programs that use the old
> sg interface. Newer programs should pass in the timeout themselves, or
> set IMMED as somebody else in this thread noted.

If you do use the sg interface, you can specify the timeout.
If you use SCSI_IOCTL_SEND_COMMAND, there's no way to do it and
the value from scsi_ioctl.c applies.

scsiformat is one of the users.

> So I do think the easiest is just to patch this define for the odd case,
> and forget about it.

Agreed.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--oIMVlEQ///Q2JYC7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoP6+xmLh6hyYd04RAgaPAKDHOe0IgAYExTCEPQXGov1+3OIHKACfYRkV
qBC77/SVlmIc1ynkSwM8lrg=
=Kvbx
-----END PGP SIGNATURE-----

--oIMVlEQ///Q2JYC7--
