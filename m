Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUJRJdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUJRJdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJRJdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:33:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:50354 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265161AbUJRJdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:33:12 -0400
Date: Sun, 17 Oct 2004 23:44:38 +0200
From: Kurt Garloff <garloff@suse.de>
To: Robert Love <rml@novell.com>
Cc: "Timothy D. Witham" <wookie@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Announcing Binary Compatibility/Testing
Message-ID: <20041017214438.GA7202@tpkurt.wlan.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Robert Love <rml@novell.com>, "Timothy D. Witham" <wookie@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1097705813.6077.52.camel@wookie-zd7> <416DAEB7.4050108@pobox.com> <1097709855.5411.20.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1097709855.5411.20.camel@localhost>
X-Operating-System: Linux 2.6.8-7-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Wed, Oct 13, 2004 at 07:24:15PM -0400, Robert Love wrote:
> I'd venture, in fact, to say that this effort is very important but does
> not affect the kernel at all.  Current "fault" lies in things e.g. like
> the C++ ABI, which is constantly fluctuating (rightly so, to fix bugs,
> but still).

These days, it's mostly libstdc++ which is still developing; the
compiler side (name mangling, layout of virt tables, ...) is quite
stable these days; it's these occasional bugs which are found from=20
time to time in the most obscure scenarios, which are often overstated.

> Any other incompatibility lies in libraries, but we have library
> versioning.  There is nothing wrong with newer libs breaking
> compatibility so long as they have a different soname.  Vendors just
> need to ship compat libs and ISV's need to make sure they request the
> right lib and don't touch internals.

Except that we have deeps stacks of libraries these days and things=20
break apart if you need different versions of one library at the same
time ...=20

D needs libs C and B, but C needs A and B needs A'.
In reality, the picture is many more levels deep.

Thus breaking libs all the time brings nice challenges for integrators
and ISVs as well. Fortunately, most libs don't do that.

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcufGxmLh6hyYd04RArihAKDBOp/d6roL1urdxQC6XSrvQiSnmgCfRurS
yp/AtkPOSnit3ooK76zod9A=
=svx4
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
