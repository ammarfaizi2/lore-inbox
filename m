Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUFIPEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUFIPEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUFIPEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:04:15 -0400
Received: from lists.us.dell.com ([143.166.224.162]:42308 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266156AbUFIPEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:04:05 -0400
Date: Wed, 9 Jun 2004 10:04:03 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid hangs at boot on linux-2.4.27-pre1 20 second delay at lilo prompt makes it succeed
Message-ID: <20040609150403.GB5103@lists.us.dell.com>
References: <40BD03C8.5060504@mnsu.edu> <40BE4002.5010905@mnsu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <40BE4002.5010905@mnsu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2004 at 04:00:50PM -0500, Jeffrey E. Hundstad wrote:
> >While booting linux-2.4.27-pre1 the system hangs.  If I put a 20=20
> >second delay in at the lilo prompt then the system always boot=20
> >successfully.  ...I just pulled 20 seconds out of the air... less time=
=20
> >might work,  but I haven't tried.  I've also tried linux-2.4.24 with=20
> >the same results.
>
> It hangs in the place indicated below:
>=20
> SCSI subsystem driver Revision: 1.00
> Red Hat/Adaptec aacraid driver (1.1-3 Apr 22 2004 14:34:42)
> AAC0: kernel 2.8.4 build 6089
> AAC0: monitor 2.8.4 build 6089
> AAC0: bios 2.8.0 build 6089
> AAC0: serial 635081d3fafaf001
> scsi0 : percraid
> ------ THE SYSTEM HANGS HERE ------
>  Vendor: DELL      Model:                   Rev: V1.0
>  Type:   Direct-Access                      ANSI SCSI revision: 02


It appears that the adapter is slow to respond to commands at this
point.  It's possible that this is related to the firmware cache flush
issue we're aware of.

Can you please follow the instructions at=20
http://lists.us.dell.com/pipermail/linux-poweredge/2004-May/020104.html
which describe how to disable the read and write caches using the
afacli command and see if that solves it for you?  If so, then the
permanent solution will be a new firmware when released.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAxybjIavu95Lw/AkRArjmAJ95+1nxVVqk5noVt7QC6gYWMrf5uACbB3ju
nSCAYgL2Q7hKSwNPjQ9ZKTc=
=s8aQ
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
