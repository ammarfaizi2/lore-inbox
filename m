Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUIGMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUIGMrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUIGMrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:47:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29122 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268005AbUIGMrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:47:31 -0400
Date: Tue, 7 Sep 2004 14:47:26 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: attribute warn_unused_result
Message-ID: <20040907124726.GF8237@devserv.devel.redhat.com>
References: <413DA83A.7010704@kolivas.org> <1094560688.2801.11.camel@laptop.fenrus.com> <413DAD07.3030306@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <413DAD07.3030306@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 07, 2004 at 10:43:51PM +1000, Con Kolivas wrote:
> Arjan van de Ven wrote:
> >On Tue, 2004-09-07 at 14:23, Con Kolivas wrote:
> >
> >>Gcc3.4.1 has recently been complaining of a number of unused results 
> >>from function with attribute warn_unused_result set. I'm not sure of how 
> >>you want to tackle this so I'm avoiding posting patches. Should we 
> >>remove the attribute (seems the likely option) or set some dummy 
> >>variable (sounds stupid now that I ask it).
> >
> >
> >that attribute is supposed to only be set for functions you really ought
> >to check the result for.... so how about checking/using the result ?
> 
> I understand the concept... these are functions that seem to work fine 
> without using the return value... unless of course the original coders 
> aren't yet aware of that fact then I'm sorry. Here's the list just with 
> my config on 2.6.9-rc1-bk13:

> fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result

you really are supposed to use the return value of copy_to_user and friends.

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBPa3dxULwo51rQBIRAoHOAJ4j/ZVC53HPNk81DlQt33p53Ca3jgCeNfU/
mKF+K7YnLN00Y2Bp5fsTzc4=
=veb7
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
