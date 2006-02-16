Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWBPLas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWBPLas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWBPLar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:30:47 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:20620 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751365AbWBPLar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:30:47 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139779983.5247.39.camel@localhost.localdomain>
	<87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139870065.5237.26.camel@localhost.localdomain>
	<17394.48045.253033.885865@cargo.ozlabs.ibm.com>
Date: Thu, 16 Feb 2006 11:30:37 +0000
In-Reply-To: <17394.48045.253033.885865@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Wed, 15 Feb 2006 16:27:09 +1100")
Message-ID: <87y80bilr6.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Paul Mackerras <paulus@samba.org> writes:

> Benjamin Herrenschmidt writes:
>
>> Ok, does not using NTP fixes it ?
>
> Try this patch.  With this the values from gettimeofday() or the VDSO
> should stay exactly in sync with xtime even if NTP is adjusting the
> clock.
>
> This patch still has quite a few debugging printks in it, so it's not
> final by any means.  I'll be interested to hear how it goes, and in
> particular whether or not you see any "oops, time got ahead" messages.

Without your patch, the clock works perfectly when NTP is not in use,
but when NTP is in use I get a large amount of skew (3 min) after
about half an hour.

With your patch (tested against 2.6.16-rc3), there is no skew whether
NTP is running or not, and the system has been up 90 mins so far.
They two times appear to be the same.


Regards,
Roger

=2D-=20
Roger Leigh
                Printing on GNU/Linux?  http://gutenprint.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your m=
ail.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD9GJhVcFcaSW/uEgRAiAYAJ948nKcjhZlXZvBgc7Bu8xqBUqezQCgnHx2
nJqNTMs+yzjEgFsfcfwYbI4=
=YR/n
-----END PGP SIGNATURE-----
--=-=-=--
