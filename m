Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUEFHvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUEFHvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUEFHvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:51:23 -0400
Received: from mx2.redhat.com ([66.187.237.31]:45201 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S261416AbUEFHvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:51:20 -0400
Date: Thu, 6 May 2004 09:50:44 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506075044.GC12862@devserv.devel.redhat.com>
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20040506084918.B12990@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 06, 2004 at 08:49:18AM +0100, Christoph Hellwig wrote:
> On Thu, May 06, 2004 at 09:04:49AM +0200, Arjan van de Ven wrote:
> > +static int ide_disk_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
> > +{
> > +	ide_hwif_t *hwif;
> > +	ide_drive_t *drive;
> > +	int i, unit;
> > +	
> > +	switch (event) {
> > +		case SYS_HALT:
> > +		case SYS_POWER_OFF:
> > +			break;
> > +		default:
> > +			return NOTIFY_DONE;
> > +	}
> 
> Please don't use reboot notifiers in new driver code.  The driver
> model has a ->shutdown method for that.

there is somewhat of a problem with that; the reboot command potentially
runs from the disk in question, so that might never get called since that
will keep things busy.

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAme5TxULwo51rQBIRAuE+AKCCbsnIZxVs2OUMJJoFeSOU+JEJmACdEk/4
6u4ZPNstVrdwNENX6NPQ0Gw=
=H80P
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
