Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUIABNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUIABNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUIABNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:13:45 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61606 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268991AbUIABIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:08:45 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Date: Wed, 1 Sep 2004 11:08:40 +1000
Subject: Re: kbuild: Support LOCALVERSION
Message-ID: <20040901010840.GL2897@cse.unsw.EDU.AU>
References: <20040831192642.GA15855@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <20040831192642.GA15855@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 31, 2004 at 09:26:43PM +0200, Sam Ravnborg wrote:
> The following patch combines the request from several people.
> If you place a file named localversion* in the root of your
> soruce tree or the root of your output tree the text included in this
> file will be appended to KERNELRELEASE.

With this patch *without* a localversion file I get

ianw@baci:/tmp/kbuild-test$ make
cat: /tmp/kbuild-test/localversion*: No such file or directory
make: *** No rule to make target `/tmp/kbuild-test/localversion*', needed by `include/linux/version.h'.  Stop.

However, with the right files there it works as you describe.

The interaction with LOCALVERSION from the command line (i.e. make
LOCALVERSION=aversion) is still a bit funny too, since it won't cause
version.h to be rebuilt.  Is it going to just be a case of "you can't
specify LOCALVERSION" from the command line?

My original patch also had a Kconfig option which would be inserted; I
figured this might be good because if you're creating a bunch of
different configs you are probably in [menu|x]config to change the
options, so it might be convenient to just set it via a string in
there.  Would anyone else like to see that?

-i

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNSEXWDlSU/gp6ecRAnqtAKDWSBAXCbRU5JZKHDEJDXn6Mrd5xACglHQq
jshiV8//1scRX+W8mEIJjcA=
=YFY5
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
