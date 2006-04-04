Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWDDKBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWDDKBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 06:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWDDKBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 06:01:17 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:64267 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S964898AbWDDKBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 06:01:17 -0400
Date: Tue, 4 Apr 2006 10:01:15 +0000
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060404100115.GI3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <20060402114215.GA30491@suse.de> <20060404085729.GH3443@getafix.willow.local> <20060404094124.GA22332@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <20060404094124.GA22332@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2006 at 11:41:24AM +0200, Olaf Hering <olh@suse.de> wrote:
> I think this should go into the main makefile, HOSTCFLAGS or similar. If
> you look around quickly in the gentoo bugzilla, all non-userland
> packages (grub, xen, kernel etc.) require the -fno-feature.

I'm not completely sure I understand where you are coming from here?
I assume you mean adding -fno-stack-protector to the host userlands
CFLAGS variable (or similar) to make it a global change, but if so
you're missing my point.

Effectively, anyone who currently has -fstack-protector enabled in
userland (regardless of distribution, or otherwise) will fail to build
the tools required. I do realise that gcc should not call this stuff
with ssp enabled, but there are legitimate cases for this to happen.
Also, just to bare in mind that this does not occur anywhere else except
for the "self-contained" code in arch/powerpc/boot, and it only occurs
here because we have a different userland and kernel ABI.

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMkPrNzVYcyGvtWURAsblAKCwDfywmfmStsQcuHhiMMqTJZClZwCgqZEY
sPa2lWxJfnMqSDBICS5O1Ns=
=+nbR
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
