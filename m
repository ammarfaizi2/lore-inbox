Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKMVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKMVto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKMVto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:49:44 -0500
Received: from smtp05.auna.com ([62.81.186.15]:26252 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1750719AbVKMVtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:49:43 -0500
Date: Sun, 13 Nov 2005 22:49:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: x86 building altivec for raid ?
Message-ID: <20051113224918.48f76cb5@werewolf.auna.net>
In-Reply-To: <17271.44949.625740.612801@cse.unsw.edu.au>
References: <20051113220213.55fc6fae@werewolf.auna.net>
	<17271.44949.625740.612801@cse.unsw.edu.au>
X-Mailer: Sylpheed-Claws 1.9.100cvs7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_.Qsq=KuNFOqX+3AOo_rR_Gx";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.105] Login:jamagallon@able.es Fecha:Sun, 13 Nov 2005 22:49:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_.Qsq=KuNFOqX+3AOo_rR_Gx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Nov 2005 08:26:45 +1100, Neil Brown <neilb@suse.de> wrote:

> On Sunday November 13, jamagallon@able.es wrote:
> >=20
> > Kernel is 2.6.14-mm2.
> > This is an x86 box, why does it compile raid6altivec*.c ? I suppose it
> > does not generate any code, because of some #ifdef magic, but why does
> > it build them anyways ? Looks a bit strange.
>=20
> It's probably just easier that way.
> I guess you could do the following, but I'm not sure that it is really
> worth it.
>=20
> +raid6-$(CONFIG_X86) :=3D  raid6mmx.o raid6sse1.o
> +raid6-$(CONFIG_X86_64) :=3D raid6sse2.o

plain x86 can also do some sse2 ;) (x2, not x4)
As X86_64 also defines plain X86, this could be just

> +raid6-$(CONFIG_X86) :=3D  raid6mmx.o raid6sse1.o raid6sse2.o

And perhaps IA64 will need this also ?
Thanks, anyways.
I will send it to Andrew, to see if it goes in.

by

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam2 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_.Qsq=KuNFOqX+3AOo_rR_Gx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDd7TeRlIHNEGnKMMRAgr2AJ9MXrnEZuRDQmfVmtbHLnKHKRYw7gCfcAoz
CnjWfe0h9h/3TaGWGKFOUI0=
=SbeB
-----END PGP SIGNATURE-----

--Sig_.Qsq=KuNFOqX+3AOo_rR_Gx--
