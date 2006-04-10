Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWDJHXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDJHXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWDJHXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:23:18 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:10634 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751062AbWDJHXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:23:17 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Denis Vlasenko <vda@ilport.com.ua>, SCSI List <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: [PATCH] deinline some functions in aic7xxx drivers, save 80k of text
Date: Mon, 10 Apr 2006 09:19:19 +0200
User-Agent: KMail/1.9.1
References: <200604100844.12151.vda@ilport.com.ua> <200604100903.35431.eike-kernel@sf-tec.de> <200604101015.36869.vda@ilport.com.ua>
In-Reply-To: <200604101015.36869.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1735792.7TOZKksDQo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604100919.23244.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1735792.7TOZKksDQo
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Full quote and readded CC adresses. My fault, pressed wrong button]

Denis Vlasenko wrote:
> On Monday 10 April 2006 10:03, Rolf Eike Beer wrote:
> > Am Montag, 10. April 2006 07:49 schrieben Sie:
> > > On Monday 10 April 2006 08:44, Denis Vlasenko wrote:
> > > > I also spotted two bugs in the process, patches
> > > > for those will follow.
> > >
> > > ahd_delay(usec) is buggy. Just think how would it work
> > > with usec == 1024*100 + 1...
> >
> > This is unneeded. The biggest argument this function is ever called with
> > is 1000.
>
> I know.
>
> > I would suggest to delete this function completely. If one ever has to
> > wait for a longer period mdelay() is the right function to call.
>
> I am leaving it up to maintainer to decide. After all, the driver
> is for multiple OSes, other OS may lack mdelay().

The comment says about multiple milliseconds sleeps which just don't happen.

Eike

--nextPart1735792.7TOZKksDQo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBEOgb7XKSJPmm5/E4RAk+TAJwPY+pGOAZUzzOkosqbBp10V/1PDwCfRqba
uZjUfV17FHWkHwIpV9B5WZ4=
=3QeF
-----END PGP SIGNATURE-----

--nextPart1735792.7TOZKksDQo--
