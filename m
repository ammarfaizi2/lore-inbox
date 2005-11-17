Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVKQT64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVKQT64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVKQT64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:58:56 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:14776 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S964841AbVKQT6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:58:55 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH 02/02] USB: add dynamic id functionality to USB core
Date: Thu, 17 Nov 2005 20:58:42 +0100
User-Agent: KMail/1.7.2
Cc: Greg KH <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
References: <20051117003241.GC14896@kroah.com> <Pine.LNX.4.44L0.0511171049070.5089-100000@iolanthe.rowland.org> <20051117162533.GB26824@suse.de>
In-Reply-To: <20051117162533.GB26824@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1913874.3OIxKZYTDZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511172058.48797.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1913874.3OIxKZYTDZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thursday 17 November 2005 17:25, Greg KH wrote:
> On Thu, Nov 17, 2005 at 10:55:33AM -0500, Alan Stern wrote:
> > On Wed, 16 Nov 2005, Greg KH wrote:
> > > +static int usb_create_newid_file(struct usb_driver *usb_drv)
> > > +{
> > > +	int error =3D 0;
> > > +
> > > +	if (usb_drv->probe !=3D NULL)
> > > +		error =3D sysfs_create_file(&usb_drv->driver.kobj,
> > > +					  &driver_attr_new_id.attr);
> > > +	return error;
> > > +}
> >=20
> > This deserves to be an inline function.

Come on, this is just a gloryfied if :-)

static inline int usb_create_newid_file(struct usb_driver *usb_drv)
{
	if (usb_drv->probe !=3D NULL) {
		return sysfs_create_file(&usb_drv->driver.kobj,
					  &driver_attr_new_id.attr);
	} else {
		return 0;
	}
}

> It's just not worth it to inline these, it's not speed critical at all.
> I prefer to not inline stuff unless it help out somehow.

I think this could help GCC, but this should be proved, of course :-)

Regards

Ingo Oeser



--nextPart1913874.3OIxKZYTDZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDfOD4U56oYWuOrkARAoEJAKDF1eUnDWXfonkVeUDWM2scwkyD1ACfcV8k
IJHFlm/B88dqtv/1fXDxsLA=
=c+w4
-----END PGP SIGNATURE-----

--nextPart1913874.3OIxKZYTDZ--
