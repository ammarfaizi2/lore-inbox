Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWIROWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWIROWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWIROWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:22:00 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:19639 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964880AbWIROV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:21:59 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Exporting array data in sysfs
Date: Mon, 18 Sep 2006 16:22:07 +0200
User-Agent: KMail/1.9.4
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200609181359.31489.eike-kernel@sf-tec.de> <200609181541.57164.eike-kernel@sf-tec.de> <d120d5000609180656t2c6be385r4ad21d52313ac187@mail.gmail.com>
In-Reply-To: <d120d5000609180656t2c6be385r4ad21d52313ac187@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8115209.RsmrdoQtL3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181622.07681.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8115209.RsmrdoQtL3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dmitry Torokhov wrote:
> On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Greg KH wrote:
> > > On Mon, Sep 18, 2006 at 01:59:17PM +0200, Rolf Eike Beer wrote:
> > > > Hi,
> > > >
> > > > I would like to put the contents of an array in sysfs files. I found
> > > > no simple way to do this, so here are my thoughts in hope someone c=
an
> > > > hand me a light.
> > >
> > > What is wrong with using an attribute group for this kind of
> > > information?
> >
> > Missing documentation. Yes, this looks like I could use this at least f=
or
> > the simple interfaces (which would be enough).
>
> I imoplemented sysfs arrays and array groups once:
>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1155.html
>
> Not sure if it still appliers. Maybe Greg will consider taking it in
> if there is a user of this code.

I guess we can add some once it is in :)

It looks good, but I would change some minor things. If there is no read=20
function given I would return -EIO instead of 0, this is how other places d=
o=20
it. The limitation to 999 entries should go. But otherwise it looks very=20
similar to what I had in mind.

Thanks.

Eike

--nextPart8115209.RsmrdoQtL3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFDquPXKSJPmm5/E4RAoFYAKCe11dqLB6eZgiE2u3HXrMRf0OzZACgo8dk
WVw3klkE9RLT6trVmDXJtGA=
=w42P
-----END PGP SIGNATURE-----

--nextPart8115209.RsmrdoQtL3--
