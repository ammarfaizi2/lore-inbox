Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbTIDPnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbTIDPnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:43:40 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:20354
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S265093AbTIDPnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:43:37 -0400
Date: Thu, 4 Sep 2003 17:43:40 +0200
To: Michael Frank <mhf@linuxmail.org>
Cc: Yann Droneaud <yann.droneaud@mbda.fr>, linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030904154340.GA2874@leto2.endorphin.org>
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr> <200309042257.12739.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <200309042257.12739.mhf@linuxmail.org>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063554220.84e9@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2003 at 10:57:12PM +0800, Michael Frank wrote:
> On Thursday 04 September 2003 21:44, Yann Droneaud wrote:
> >
> > Using nasm for only one small piece of code would be a regression, imho.
>=20
> Concur, not worthwhile to start using a fairly unsupported tool in the ke=
rnel.
>=20
> As to using assembler, It is better to get rid of it but in special cases.
> Todays compilers are the better coders in 98+% of applications, and if you
> follow some of the discussions here on the list, you will be amazed what=
=20
> people do with a C compiler - all portable and much more maintainable.

The gcc optimized code for sure much better than I do, but gcc's
optimization captabilities is for sure a joke compared to the guy how wrote
2fish_86.asm (just have a look at the source). The assembler implementation
is twice as fast as the C implemention we have in the kernel. Same is true
for AES (although just 50% faster instead of 100%:
http://clemens.endorphin.org/patches/aes-i586-asm-2.5.58.diff . That's gas
btw. )

> I guess your code should be 80-90% C and 10-20% assmbler. This will make =
it
> up to 10 times a portable.  =20

The Twofish code is C but has hooks to use an asm backend in special cases
(keysetup, en/decrypt). But a plain C version of twofish is already present
in the kernel.

> As to using nasm, note for gas and gcc 3.2+:
>=20
> + GAS does intel syntax too using  the directive
>    .intel_syntax

That's certainly nice to hear. At least some cut/pasting can be done :)

Regards, Clemens

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/V12sW7sr9DEJLk4RAn2wAJ99RUJkyQuPUY7bIsjumroSf9LLsQCfen+z
LefPF+P7FoWvNTAnComfEAk=
=qT9Q
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
