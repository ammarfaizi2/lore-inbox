Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWBLRIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWBLRIW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWBLRIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:08:21 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:45467 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750714AbWBLRIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:08:21 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rene Engelhard <rene@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc1
References: <87hd7x8uxc.fsf@hardknott.home.whinlatter.ukfsn.org>
	<43D4129C.1090205@tee.gr> <20060123225956.GD4307@rene-engelhard.de>
	<87k6c2f1x3.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139723111.5247.23.camel@localhost.localdomain>
Date: Sun, 12 Feb 2006 17:08:07 +0000
In-Reply-To: <1139723111.5247.23.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Sun, 12 Feb 2006 16:45:11 +1100")
Message-ID: <87u0b4pkso.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> Further investigation (using netconsole) shows the breakage (in
>> 2.6.16-rc1 and -rc2) is due to discovering an additional IDE
>> controller (KeyLargo) before the normal (UniNorth) controller:
>
> Some patch that went in -rc1 screwed up the existing .config's, you
> probably lost CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST

This was exactly what was missing.  Thanks all.


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

iD8DBQBD72t9VcFcaSW/uEgRAlHJAJ0bjy1/hxtKR2mZn2zPefydxlxMQgCggE1l
FS7lYxhbrV1R5S/tgfyLrrM=
=I26T
-----END PGP SIGNATURE-----
--=-=-=--
