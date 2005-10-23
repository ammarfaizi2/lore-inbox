Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVJWSzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVJWSzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJWSzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:55:49 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:59522 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750798AbVJWSzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:55:49 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Date: Sun, 23 Oct 2005 20:55:03 +0200
User-Agent: KMail/1.7.2
Cc: arjan@infradead.org, pavel@ucw.cz, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ib.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
References: <20051022231214.GA5847@us.ibm.com> <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com>
In-Reply-To: <20051023143617.GA7961@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1377088.H57GvXJQVb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510232055.17782.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1377088.H57GvXJQVb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

On Sunday 23 October 2005 16:36, Paul E. McKenney wrote:
> On Sun, Oct 23, 2005 at 09:22:18AM +0200, Ingo Oeser wrote:
> > On Sunday 23 October 2005 01:12, Paul E. McKenney wrote:
> > > +config RCU_TORTURE_TEST
> > > +	tristate "torture tests for RCU"
> > > +	default n
> >=20
> > Please put this into lib/Kconfig.debug and make it dependent on
> > DEBUG_KERNEL there, which illustrates its actual purpose much better.
>=20
> If I make it depend on DEBUG_KERNEL, I get other extraneous debug code
> as well, for example, in verify_mm_writelocked().=20

Oh, this seems to be either not intended or misguided.

DEBUG_KERNEL should do nothing more than showing the debugging
options.=20

E.g. I don't expect to enable any additional code in an=20
unrelated file, if I enable Magic-SysRQ on an embedded, unattended device
to be able to analyze potential problems via serial console.

@Andrew: Would you accept a patch to fix that?

My idea to put the option into lib/Kconfig.debug was just to ease=20
maintainence, once it is dependend on DEBUG_KERNEL.

On the other hand it makes sense to add another option TEST_KERNEL
and put some existing kernel internal test suites under that.

@Andrew: Would you accept a patch for this?


Regards

Ingo Oeser


--nextPart1377088.H57GvXJQVb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDW9yVU56oYWuOrkARAkA0AKDVzlEdd9p5J8CCfGW3uwzzpXgvJgCbB9MK
Eidd79azVWwit63/mql/nJA=
=V7Jj
-----END PGP SIGNATURE-----

--nextPart1377088.H57GvXJQVb--
