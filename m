Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293218AbSCOToJ>; Fri, 15 Mar 2002 14:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293217AbSCOTn6>; Fri, 15 Mar 2002 14:43:58 -0500
Received: from UX3.SP.CS.CMU.EDU ([128.2.198.103]:13348 "HELO
	ux3.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S293204AbSCOTnp>;
	Fri, 15 Mar 2002 14:43:45 -0500
Subject: Re: Kernel Level DHCP Versus udhcp
From: Justin Carlson <justincarlson@cmu.edu>
To: abdij.bhat@kshema.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001c01c1cc56$b38a3ec0$8134aa88@cam.pace.co.uk>
In-Reply-To: <001c01c1cc56$b38a3ec0$8134aa88@cam.pace.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-t2gF8pyH+8JkhenUgLGW"
X-Mailer: Evolution/1.0.2 
Date: 15 Mar 2002 14:42:52 -0500
Message-Id: <1016221377.7606.5.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t2gF8pyH+8JkhenUgLGW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-03-15 at 14:22, Abdij Bhat wrote:
> Hi,
>  I am deploying a Linux Network Stack. I am supposed to use a stable, ful=
ly
> featured, RFC compliant, small memory foot-print DHCP client for an embed=
ded
> system. We had converged on udhcp for the client. But I have found that
> there is a DCHP client implemented in the Linux Kernel ( Version 2.2.x or
> later ). This I believe can be configured by choosing the "Kernel level
> autoconfiguration".
>  I have however practically no documentation on the Kernel DHCP Client. I=
 do
> not know how buggy it is, is it a fully featured DHCP client or is it jus=
t a
> boot level DHCP client used for remote booting etc.
>  Can some body help me with this. I believe it is used only for the remot=
e
> booting, with the documentation currently available to me. How correct am=
 I?
> Can I replace the udhcp client with this one? How much of a change will I
> need to do for the replacement?

It sounds like the kernel DHCP client is not what you want.  It's really
intended for situations where you need to get dynamically assigned IP
information for a machine before you're far enough in the bootstrap to
do it in userland.

The most common situation for this that comes to mind is mounting your
root filesystem over NFS.  At least, that's the only situation for which
I've needed it.

If, as you imply, you really need a full-featured DHCP client, you
should be using something in userland.  The kernel-level one doesn't
(last I checked) handle DHCP details like temporarly IP address leases
and such; that's not the intention of having that option in the kernel.

-Justin


--=-t2gF8pyH+8JkhenUgLGW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8kk6847Lg4cGgb74RAg7lAJ9OM2Q4rrcElDK39aLekrCvcbWalQCffPTS
H7vvvrxEnCyNCLU7neZGEwU=
=ulCI
-----END PGP SIGNATURE-----

--=-t2gF8pyH+8JkhenUgLGW--

