Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbUASAje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 19:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUASAje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 19:39:34 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:45446 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264303AbUASAjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 19:39:32 -0500
Date: Mon, 19 Jan 2004 13:44:54 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Is this too ugly to merge?
In-reply-to: <20040113114913.GB269@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074473094.2361.104.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-nMmVEmKOXusSZtQOyK0p";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073609923.2003.10.camel@laptop-linux>
 <20040113114913.GB269@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nMmVEmKOXusSZtQOyK0p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

I'll take the following approach: I'm pretty sure that I've tried
suspending userspace before kernel threads before, and still ran into
possible deadlocks. Nevertheless, I'll set that up and then bang really
hard on it using Michael's test scripts, and let you know the results.
If and when we see that this approach won't cut the mustard, we can come
back to considering this approach. Sound okay?

By the way, the macros are not an alternative to the SIGSTOP-like
method. They're used with it, to ensure it works without deadlocking.

Regards,

Nigel

On Wed, 2004-01-14 at 00:49, Pavel Machek wrote:
> Okay, I can now remember (and agree to) that we need to suspend
> userspace first, and only then suspend kernelspace. Bug I don't see
> why we can't suspend userspace using old, SIGSTOP-like, method.

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-nMmVEmKOXusSZtQOyK0p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBACyiGVfpQGcyBBWkRAgyPAJ9ILf64RvvZcVbeZA1fCJjQLnS7twCgpSA2
81K/6WkSvWsfM8fTfNvfBWk=
=k9Su
-----END PGP SIGNATURE-----

--=-nMmVEmKOXusSZtQOyK0p--

