Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUHULGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUHULGp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 07:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUHULGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 07:06:45 -0400
Received: from h241-28.NTCU.net ([211.76.241.28]:51974 "EHLO wagner.elixus.org")
	by vger.kernel.org with ESMTP id S268966AbUHULF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 07:05:59 -0400
Date: Sat, 21 Aug 2004 12:05:46 +0100
From: Chia-liang Kao <clkao@clkao.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Subversion/svk mirror of the linux tree
Message-ID: <20040821110545.GA11724@portege.clkao.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

I'm pleased to announce a Subversion/svk mirror of the linux kernel
tree at:

  svn://svn.clkao.org/linux/cvs

Web interface at http://svn.clkao.org/svnweb/linux/log/cvs/

Meanwhile svk 0.19 is available:  http://freshmeat.net/releases/170508/

Before you start flaming about Subversion being centralized and not
the right model for kernel development, please take a moment to read
up about the additional features svk offers.

Please keep me CC'ed for comments, as I'm not subscribed to the list.

FAQ

* I heard that Subversion isn't the preferred revision control system for
  Linux. Why do you want to provide this mirror?

I am not telling anyone to switch to Subversion for linux development,
just helping to make the linux kernel more easily accessible to
everyone.  Users who want to checkout the latest version of the kernel
can use the increasingly popular open-source svn client to checkout.
Developers can now use svk to mirror the above url, create a local and
offline branch, generate diffs against the trunk and easily submit
their patches upstream.

You can learn more about svk at http://svk.elixus.org/.

Since the tree is quite large, you might not want to grab the entire
repository's history.  You can start off with the 100 most recent
revisions like this:

  svk mirror //linux/trunk svn://svn.clkao.org/linux/cvs
  svk sync --skipto HEAD-100 //linux/trunk

* svk is built on-top of Subversion? I heard Subversion is slow.
  Doesn't that means svk is even slower?

svk only uses the lowest two layers of Subversion, which is
well-maintained and constantly improving.  On large trees that reside
locally, svk checkout is about twice as fast as svn.

* How is the mirror provided?

svk can also mirror non-subversion repositories with the nice and
extensible VCP framework.

The exported cvs tree is rsynced, and then:

svk mirror /linux/cvs cvsbk:/home/cvs/linux:linux-2.5/... --branch-only=trunk
svk sync /linux/cvs

That's it.

The cvsbk VCP source driver can also be found on CPAN.

The first mirror took quite a few hours for the 20000+ changesets, and
the memory usage is around 200M.  Subsequent runs are usually done
within 5 minute.


ACKNOWLEDGMENT

Special thanks to xs4all.nl for providing hardware and bandwidth for
svk development and such mirror service.

Cheers,
CLK

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (FreeBSD)

iD8DBQFBJyyJk1XldlEkA5YRArRpAJ9rcWCVXyQh7Xicr9yWLUXj59JwWgCeItHb
Czt7GiI5NYvvubXM2gVbzAA=
=mvgA
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
