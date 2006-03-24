Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423002AbWCXEjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423002AbWCXEjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWCXEjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:39:09 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:54438 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423002AbWCXEjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:39:08 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI Compile error in current git (pci.h)
Date: Fri, 24 Mar 2006 14:37:18 +1000
User-Agent: KMail/1.9.1
Cc: linux-acpi@vger.kernel.org, Greg KH <gregkh@suse.de>
References: <200603241404.08109.ncunningham@cyclades.com>
In-Reply-To: <200603241404.08109.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1639322.RHo9zxKrpc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603241437.26633.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1639322.RHo9zxKrpc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again.

On Friday 24 March 2006 14:04, Nigel Cunningham wrote:
> Hi.
>
> Current git produces the following compile error (x86_64 uniprocessor
> compile):
>
> arch/x86_64/pci/mmconfig.c:152: error: conflicting types for
> =E2=80=98pci_mmcfg_init=E2=80=99 arch/i386/pci/pci.h:85: error: previous =
declaration of
> =E2=80=98pci_mmcfg_init=E2=80=99 was here make[1]: *** [arch/x86_64/pci/m=
mconfig.o] Error 1
> make: *** [arch/x86_64/pci] Error 2
>
> I haven't found out yet how the i386 file is getting included, but I
> can say that git compiled fine last night.

Got the answer to this bit - it is included via the Makefile in the directo=
ry=20
setting a -I flag, and the file including "pci.h".

Regards,

Nigel

--nextPart1639322.RHo9zxKrpc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEI3eGN0y+n1M3mo0RAlxHAJ47+FmcFCqO1H6oI71J8B5oFm91YACg5el9
C272IdRRXR4Ldm/IZyDf/m8=
=QrI4
-----END PGP SIGNATURE-----

--nextPart1639322.RHo9zxKrpc--
