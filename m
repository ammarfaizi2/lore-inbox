Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWIRP5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWIRP5S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWIRP5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:57:18 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:63929 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750928AbWIRP5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:57:17 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Exporting array data in sysfs
Date: Mon, 18 Sep 2006 17:57:25 +0200
User-Agent: KMail/1.9.4
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200609181359.31489.eike-kernel@sf-tec.de> <200609181718.35491.eike-kernel@sf-tec.de> <d120d5000609180841v436f7a32l78b26fc72f48f92a@mail.gmail.com>
In-Reply-To: <d120d5000609180841v436f7a32l78b26fc72f48f92a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3451153.9ez6vQjeyf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181757.31043.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3451153.9ez6vQjeyf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag, 18. September 2006 17:41 schrieb Dmitry Torokhov:
> On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Dmitry Torokhov wrote:
> > > On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > >>Dmitry Torokhov wrote:
> > >>> http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1155.html
> > >>
> > >> The limitation to 999 entries should go.
> > >
> > > It is not really a limitation but rather a safeguard. Do you really
> > > expect to have arrays with that many attributes?
> >
> > At least I don't know how much they will be. If the user wants to do
> > crazy things... :) I'm currently hacking on a store_n implementation,
> > perhaps I'll be able to show some code tomorrow.
>
> I do not think you shoudl allow user do crazy things. The memory is
> kmalloced so there naturally a limit on number of attrinutes that can
> be created. And I am not sure abot usefulness of resizing form
> usespace.
> Could you give me an example of a user who needs dynamic attribute arrays?

=46PGA device, number of buffers for DMA transfers. 1000 buffers should be=
=20
enough, but you'll never know what $user will do with his bigmem machine.=20
They will be able to resize anyway. If I don't get it done with 'n' it will=
=20
be an ioctl. For the moment it fails anyway since sysfs_get_dentry() got=20
removed.

This resizing stuff is purely optional. A 'n' giving me the number of entri=
es=20
would at least help coding since you can easily find out how much space you=
=20
need for reading everything in the directory. Giving a dynamic n this is=20
racy, but that's another story.

Eike

--nextPart3451153.9ez6vQjeyf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFDsHrXKSJPmm5/E4RAi7yAJ49JG3KnpdHODGmRkpo1oH+zHzvCQCeMuY2
WhMRUJSKH/QhGjmXBaVAK6E=
=Gx8i
-----END PGP SIGNATURE-----

--nextPart3451153.9ez6vQjeyf--
