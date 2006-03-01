Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWCAFLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWCAFLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 00:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWCAFLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 00:11:07 -0500
Received: from ozlabs.org ([203.10.76.45]:56207 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932318AbWCAFLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 00:11:04 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Date: Wed, 1 Mar 2006 16:10:26 +1100
User-Agent: KMail/1.8.3
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com>
In-Reply-To: <20060301043353.GJ28434@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2433551.HS0gLVgx7B";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603011610.31090.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2433551.HS0gLVgx7B
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 1 Mar 2006 15:33, Dave Jones wrote:
> On Wed, Mar 01, 2006 at 02:57:05PM +1100, Michael Ellerman wrote:
>  > On 1/20/06, Darrick J. Wong <djwong@us.ibm.com> wrote:
>  > > Hi there,
>  > >
>  > > Some old i386 systems have flaky APIC hardware that doesn't always
>  > > work right.  Right now, enabling the APIC code in Kconfig means that
>  > > the APIC code will try to activate the APICs unless 'noapic nolapic'
>  > > are passed to force them off.  The attached patch provides a config
>  > > option to change that default to keep the APICs off unless specified
>  > > otherwise, disables get_smp_config if we are not initializing the
>  > > local APIC, and makes init_apic_mappings not init the IOAPICs if they
>  > > are disabled. Note that the current behavior is maintained if
>  > > CONFIG_X86_UP_APIC_DEFAULT_OFF=3Dn.
>  >
>  > Did this hit the floor?
>
> It's still being kicked around.  I saw one patch off-list earlier this
> week that has some small improvements over the variant originally posted,
> but still had 1-2 kinks.

Cool. Let's get ironing. I have no idea about the implementation, but the=20
concept is double ++ good as far as I'm concerned.

> The number of systems that actually *need* APIC enabled are in the
> vast (though growing) minority, so it's unlikely that most newbies
> will hit this.  The problem is also the inverse of what you describe.
> Typically the distros have DMI lists of machines that *need* APIC
> to make it enabled by default so everything 'just works'.

Ok, even more reason for it to go in. Someone might want to let the folks a=
t=20
Ubuntu know too, they seem to have it enabled in their installer kernel. :D

cheers

--nextPart2433551.HS0gLVgx7B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBSzHdSjSd0sB4dIRAt8JAJwOF3/xlShx1QLvr59TI9syEUbdawCgoXtI
TZ9zEqpSv5IjyIQZtP4/U98=
=BnAl
-----END PGP SIGNATURE-----

--nextPart2433551.HS0gLVgx7B--
