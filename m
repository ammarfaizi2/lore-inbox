Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270648AbUJUI4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbUJUI4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270513AbUJUIuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:50:39 -0400
Received: from lug-owl.de ([195.71.106.12]:15530 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S270586AbUJUIrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:47:31 -0400
Date: Thu, 21 Oct 2004 10:47:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, dhowells@redhat.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-sh@m17n.org,
       linux-arm-kernel@lists.arm.linux.org.uk, parisc-linux@parisc-linux.org,
       linux-ia64@vger.kernel.org, linux-390@vm.marist.edu,
       linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041021084728.GA5033@lug-owl.de>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Andi Kleen <ak@suse.de>, dhowells@redhat.com, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net> <20041020225625.GD995@wotan.suse.de> <20041020160450.0914270b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpnyAEUPSyO7P1Gm"
Content-Disposition: inline
In-Reply-To: <20041020160450.0914270b.davem@davemloft.net>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bpnyAEUPSyO7P1Gm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-20 16:04:50 -0700, David S. Miller <davem@davemloft.net>
wrote in message <20041020160450.0914270b.davem@davemloft.net>:
> On Thu, 21 Oct 2004 00:56:25 +0200
> Andi Kleen <ak@suse.de> wrote:

*VAX hacker's hat on*

> I disagree quite strongly.  One major frustration for users of
> non-x86 platforms is that functionality is often missing for some
> time that we can make trivial to keep in sync.

Full ACK.

> Simply put, if you're not watching the tree in painstaking detail
> every day, you miss all of these enhancements.

Right; and these missing enhancements will cause extra-pain when they're
used some time later from core code. That is, you missed the feature
while it was discusses/accepted and need to put it in place later on. So
you've got to do extra searching etc.

> The knowledge should come from the person putting the changes into
> the tree, therefore it gets done once and this makes it so that
> the other platform maintainers will find out about it automatically
> next time they update their tree.

Here's my proposal:

$ mkdir ./Documentation/new_enhancements_to_implement
$ cat ./Documentation/new_enhancements_to_implement/new_key_syscalls << EOF
> Dear Architecture Maintailers,
>=20
> please add these four new cryptographic key functions to your syscall
> table. It's quite easy; just extend the ./include/arch-xxx/unistd.h
> for four new defines and then add them to your ./arch/xxx/kernel/entry.S
> file. For reference, here's my i386 patch doing this:
>=20
> diff -Nurp
> --- path-old/to/file/one
> +++ path-new/to/file/one
>  text
> -del
> +add
>  more text
>=20
>=20
> Thanks, your keychain hacker:-)
> EOF
$

This way, all arch maintainers just *see* what needs to be done and
get a small introduction on how to do that. I'd *really* like to see
that! That would particularly help those that cannot do full-time
hacking on their port (like us VAX hackers:-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--bpnyAEUPSyO7P1Gm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBd3egHb1edYOZ4bsRAjiYAKCGSC9V5w2kdxwg0IEMdrNz/AtYggCdFNim
HrmvljvO83mhAXd2vnQzg5w=
=kfus
-----END PGP SIGNATURE-----

--bpnyAEUPSyO7P1Gm--
