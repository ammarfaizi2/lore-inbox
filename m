Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbUCTNHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbUCTNHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:07:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263395AbUCTNHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:07:22 -0500
Subject: Re: "Enhanced" MD code avaible for review
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Scott Long <scott_long@adaptec.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-raid@vger.kernel.org, "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4058EBEC.8070309@adaptec.com>
References: <459805408.1079547261@aslan.scsiguy.com>
	 <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com>
	 <200403172245.31842.bzolnier@elka.pw.edu.pl> <4058EBEC.8070309@adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NWjSvf2bI86hvNyNtwmL"
Organization: Red Hat, Inc.
Message-Id: <1079788027.5225.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 20 Mar 2004 14:07:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NWjSvf2bI86hvNyNtwmL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> With DM, what happens when your initrd gets accidentally corrupted?

What happens if your vmlinuz accidentally gets corrupted? If your initrd
is toast the module for your root fs doesn't load either. Duh.

> What happens when the kernel and userland pieces get out of sync?
> Maybe you are booting off of a single drive and only using DM arrays
> for secondary storage, but maybe you're not.  If something goes wrong
> with DM, how do you boot?

If you loose 10 disks out of your raid array, how do you boot ?

>=20
> Secondly, our target here is to interoperate with hardware components
> that run outside the scope of Linux.  The HostRAID or DDF BIOS is
> going to create an array using it's own format.  It's not going to
> have any knowledge of DM config files,=20

DM doesn't need/use config files.
> initrd, ramfs, etc.  However,
> the end user is still going to expect to be able to seamlessly install
> onto that newly created array, maybe move that array to another system,
> whatever, and have it all Just Work.  Has anyone heard of a hardware
> RAID card that requires you to run OS-specific commands in order to
> access the arrays on it?  Of course not.  The point here is to make
> software raid just as easy to the end user.

And that is an easy task for distribution makers (or actually the people
who make the initrd creation software).

I'm sorry, I'm not buying your arguments and consider 100% the wrong
direction. I'm hoping that someone with a bit more time than me will
write the DDF device mapper target so that I can use it for my
kernels... ;)


--=-NWjSvf2bI86hvNyNtwmL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAXEH7xULwo51rQBIRAuo0AJ42KhIBPDMtwLHQ+pJBxZ6pl3Ok7wCaA0gW
IBgPNKV0WFO8y+nkXtMqKJc=
=9ZZ5
-----END PGP SIGNATURE-----

--=-NWjSvf2bI86hvNyNtwmL--

