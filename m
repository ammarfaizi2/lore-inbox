Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUHKWTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUHKWTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUHKWTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:19:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:50844 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268273AbUHKWTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:19:06 -0400
Date: Thu, 12 Aug 2004 00:19:03 +0200
From: Kurt Garloff <garloff@suse.de>
To: James Morris <jmorris@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040811221903.GA14744@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Morris <jmorris@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040810085746.GB12445@tpkurt.garloff.de> <Xine.LNX.4.44.0408101006580.7711-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408101006580.7711-100000@dhcp83-76.boston.redhat.com>
X-Operating-System: Linux 2.6.7-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 10, 2004 at 10:16:29AM -0400, James Morris wrote:
> Is this just an ia64 issue?  If so, then perhaps we should look at only
> penalising ia64?  Otherwise, loading an LSM module is going to cause
> expensive false unlikely() on _every_ LSM hook.

You should worry about the fast path.
That's no LSM being loaded and just using the default capabilities.
Which is what most users usse as of this time.
If you do call into any serious LSM, you'll spend much more CPU cycles
anyway ...

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBGptXxmLh6hyYd04RAmG3AKCbE4d3UN521RWJIeSufHvyzgoFPwCgkZJ5
ecTBFNF89/PX0akXdUsPMZQ=
=Aoar
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
