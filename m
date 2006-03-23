Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWCWNWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWCWNWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWCWNWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:22:19 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:2197 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932093AbWCWNWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:22:18 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Date: Thu, 23 Mar 2006 23:20:33 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603232151.47346.ncunningham@cyclades.com> <20060323130919.GZ4285@suse.de>
In-Reply-To: <20060323130919.GZ4285@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2906348.2Zgl3vlDII";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603232320.39724.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2906348.2Zgl3vlDII
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Thursday 23 March 2006 23:09, Jens Axboe wrote:
> On Thu, Mar 23 2006, Nigel Cunningham wrote:
> > diff -ruNp 9904-libata-freeze.patch-old/drivers/scsi/libata-scsi.c
> > 9904-libata-freeze.patch-new/drivers/scsi/libata-scsi.c ---
> > 9904-libata-freeze.patch-old/drivers/scsi/libata-scsi.c	2006-03-23
> > 21:16:22.000000000 +1000 +++
> > 9904-libata-freeze.patch-new/drivers/scsi/libata-scsi.c	2006-03-23
> > 21:24:06.000000000 +1000 @@ -419,7 +419,7 @@ int
> > ata_scsi_device_suspend(struct scsi_
> >  	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
> >  	struct ata_device *dev = &ap->device[sdev->id];
> >
> > -	return ata_device_suspend(ap, dev);
> > +	return ata_device_suspend(ap, dev, state);
> >  }
>
> Eh this looks odd, you are forgetting to add pm_message_t state as an
> extra argument to that function.
>
> Apart from that, patch looks good. It should definitely be included
> asap.

Good catch! Fixed, will resend.

Thanks!

Nigel

--nextPart2906348.2Zgl3vlDII
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIqCnN0y+n1M3mo0RAt1UAKDm+nFgtYW87RUdku9OwKGbkUjnlACdEs10
GzXVLZ3rx44r33b+qwu61Lo=
=Gcki
-----END PGP SIGNATURE-----

--nextPart2906348.2Zgl3vlDII--
