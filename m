Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUANW1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUANW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:27:34 -0500
Received: from [199.103.152.44] ([199.103.152.44]:9603 "EHLO localhost")
	by vger.kernel.org with ESMTP id S264420AbUANWZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:25:07 -0500
Subject: Re: VIA and NVIDIA
From: eddie tejeda <eddie@nailchipper.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040114201637.566a9330@Genbox>
References: <1074106424.6839.15.camel@applehead>
	 <20040114201637.566a9330@Genbox>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iiR7hiXc24aPaQYj0Yps"
Message-Id: <1074119294.6055.1.camel@applehead>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Jan 2004 17:28:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iiR7hiXc24aPaQYj0Yps
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

i reply to you.. but in response to everyone's suggestions:


the workarounds that i said i tried are exactly those being suggested
here today.

i've done all the settings pertaining to acpi and apm.. also the one
about NvAGP..

> I could ssh in and use
> strace -p <pid of X server> and all I would see is constant calls
> to gettimeofday().  Nothing I would try worked. =20

when i do that i see.. nothing....

>   Finally, I decided to swap the cards around.  The X server would
> start up on my machine at work.  I could log in.  Usually, approx
> 3 minutes after booting, it would lock up with a similar signature
> to the above.

i've waited 15min... and have tried other vidcards.

..about max's suggestions.. PNP is disabled. dmesg shows no real
problems..

and to nuno.. i've tried those settings before.. (agpgart, no fb,etc)
tried them again before responding... nothing..


i dont know what to say..... i mean...not all configurations of hardware
are tested before being code being released. i may have just stumbled
upon a not so friendly config.. whether its
motherboard,bios,kernel,videocard,videodriver... i dont know..


i've recently set kernel to be as verbose as possible.. nothing
interesting is printed.. when i look at the logs everything is fine....
we can see in the log that the last thing is it does is set resolution..

Jan 14 16:29:12 applehead kernel: nvidia: module license 'NVIDIA' taints
kernel.
Jan 14 16:29:12 applehead kernel: 0: nvidia: loading NVIDIA Linux x86
nvidia.o Kernel Module  1.0-5328  Wed Dec 17 13:54:51 PST 2003
Jan 14 16:29:13 applehead kernel: 0: NVRM: not using NVAGP, AGPGART is
loaded!!

and AGPGART is even working!

if it  was up to the logs.. .everything is fine and dandy... its only me
who claims it not to be working.


-eddie


On Wed, 2004-01-14 at 14:16, Nuno Alexandre wrote:
> On Wed, 14 Jan 2004 13:53:45 -0500=20
> eddie tejeda wrote:
>=20
> > I have an NVidia Videocard with a VIA KT333 chipset motherboard..
> >=20
> > i am about to burst.. i am tried just about every bug-fix, workaround
> > and hack, written everywhere in the internet.. to get the Nvidia driver
> > to work on my machine. NV works fine.
> >=20
> > i've been trying this for 6months and finally caving and think that it
> > has to be Linux's VIA support. which i've read there are some problems.
> >=20
> > I am willing to present all information needed.. but this is the post
> > i've posted all over NVIDIA boards:
> >=20
> >=20
> >=20
> > ***********
> >=20
> >=20
> > The screen used to go black, and flicker blue once, and stop responding=
.
> > number lock works... i can SSH into machine to get logs.. if i try and
> > kill X it crashes the machine hard... complete lock out...
> >=20
> > when i run ps aux i can see X is running 99% of CPU
> >=20
> > All the options enabled in XFConfig attached have been added and remove=
d
> > (when options are removed the flicker happens.. if not... I now get a
> > screen with ASCII printed.. just junk.. no flicker.)
> >=20
> > I have:
> > Athlon XP 2200
> > Soyo Ultra Platinum, KT333
> > PNY GeForce 3 Ti200
> > Crucial 512 DDR-333
> > ALL tested kernels (2.4.22+, 2.6.x)
> > ALL distributions (Fedora, Redhat, Debian)
> >=20
> > I have tested with following kernel options on and off:
> > ACPI/APM
> > Fb-Nvidia/Riva
> > Pre-empt
> > AGPART
> >=20
> > i attached my XFConfig, XFree86.log and .config(2.6.0)
> >=20
> >=20
> > ************
> >=20
> >=20
> > i am almost certain it is linux.. because the cards work on windows
> > machines perfect. and i have tried a few cards on this linux machine th=
e
> > same happens.
> >=20
> > also, most people who have the problems i described.... they get fixed
> > with the OPTIONS that i have on my XF86Config. i have tested them all o=
n
> > and off.
> >=20
> >=20
> > i would like to see linux do 3d.. one day. :o)...thanks in advance, i
> > love the work you guys do and hope to contribute in the future..=20
> >=20
>=20
> Hi Eddie.
> I have Asus A7V, KT 333
> AMD 1800+
> Gforce 2gts
> 768 DDR Kingston
>=20
> settings on
> pre-empt
> AGPART
>=20
> not using framebuffer.
> As you see, very similar setup, apart from the riva fb.
> But I have had  a framebuffer working with help from some patches availab=
le on the gentoo forums, but they don't work on the latest
> kernel build. So i dropped it.
>=20
> I never had any problems with the nvidia drivers.
> not on 2.4 or 2.6 always worked :)
>=20
> I dont know how this can help you, but having 2 similar setups
> maybe helps finding whats wrong on your setup that makes it not work.
> Feel free to ask for anything that might help you.

--=-iiR7hiXc24aPaQYj0Yps
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABcJ+BiLsaFIGFU0RAjuZAJwOdlmKk/v4WFIp619VO9DRp/aY9QCfQm5t
tlAgpZH87CMUnIzPy1Cp3M8=
=eFPk
-----END PGP SIGNATURE-----

--=-iiR7hiXc24aPaQYj0Yps--

