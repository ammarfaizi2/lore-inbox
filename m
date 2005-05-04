Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVEDNz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVEDNz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVEDNzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:55:55 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:8377 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261833AbVEDNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:55:42 -0400
Date: Wed, 4 May 2005 15:55:37 +0200
From: Martin Waitz <tali@admingilde.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System call v.s. errno
Message-ID: <20050504135537.GE3562@admingilde.org>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DuNoGD3ogd33HnLq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DuNoGD3ogd33HnLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, May 04, 2005 at 09:22:09AM -0400, Richard B. Johnson wrote:
> Does anybody know for sure if global 'errno' is supposed to
> be altered after a successful system call? I'm trying to
> track down a problem where system calls return with EINTR
> even though all signal handlers are set with SA_RESTART in
> the flags.

syscalls are only automatically restarted by the interrupt if the
syscall returns -ERESTARTSYS. If it returns -EINTR itself then that will
be delivered to userspace even when it sets SA_RESTART.

--=20
Martin Waitz

--DuNoGD3ogd33HnLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCeNRYj/Eaxd/oD7IRAomRAKCDmGEk4uAcnPRJ/LJN0/spj3W3ywCfWkx2
/myGu1YQLkVaBRR8fcZshRw=
=zj61
-----END PGP SIGNATURE-----

--DuNoGD3ogd33HnLq--
