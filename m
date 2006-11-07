Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWKGGHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWKGGHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWKGGHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:07:13 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:34723 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932091AbWKGGHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:07:10 -0500
Message-ID: <4550228A.6060701@freedesktop.org>
Date: Mon, 06 Nov 2006 22:07:06 -0800
From: Josh Triplett <josh@freedesktop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: ANNOUNCE: Sparse 0.1 - first release version of Sparse; new maintainer
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEAEB546D91651AA04C05A1F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAEB546D91651AA04C05A1F0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have tagged and tarballed a 0.1 release of Sparse, now available
from:

<http://kernel.org/pub/linux/kernel/people/josh/sparse/dist/sparse-0.1.ta=
r.gz>
sha1sum: 9e0a4d5abb8e8a4be4cf8d9fe632c69dbec3e242=20

As discussed in
<http://marc.theaimsgroup.com/?i=3DPine.LNX.4.64.0610311030370.25218@g5.o=
sdl.org>,
I've taken maintainership of sparse.  Thanks to Linus Torvalds for his
previous maintainership.

As a result, this release comes from my sparse Git repository.  You can
obtain the latest version of sparse directly from my Git repository with
the command:

    git clone git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.g=
it

You can also browse the Git repository via gitweb, at
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/josh/sparse.git>

This release corresponds to the Git tag "0.1", signed by my GPG key,
with key ID D0FE7AFB.  In the sparse Git repository, you can verify this
tag with the command:

    git verify-tag 0.1

I've chosen to use a versioning system similar to the current system
used for the Linux kernel, with s/2\.6/0/.  The major number (0 for this
release) will change only with major architectural changes to Sparse.
The minor number (1 for this release) represents the normal release
number; thus, the next release will have version 0.2.  If a need arises
to make bugfixes to a released version of sparse, the bugfix versions
will use a third, micro number; for example, a bugfix release for 0.1
would use the version number 0.1.1.  (I considered the idea of using the
old Linux versioning system, with the odd/even unstable/stable
convention for the second number, but I believe that git feature
branches should satisfy any need for an "unstable" tree.)

In addition to all the work in the previous Sparse repository
(pub/scm/devel/sparse/sparse.git), this release includes the following
changes:

Adam DiCarlo (1):
      Add type information to enum mismatch warning

Al Viro (2):
      added a bunch of gcc builtins
      switch to hash-based get_one_special()

Josh Triplett (15):
      "Initializer entry defined twice" should not trigger with zero-size=
 fields
      Fix incorrect symbol in comment on #endif for multiple-inclusion gu=
ard
      Add -Wno-uninitialized
      graph: Show position in basic block nodes
      bb_terminated: Use boundary values rather than specific opcodes
      Turn on -Wcontext by default
      Merge branch 'fix-defined-twice-error-on-empty-struct' into staging=

      Merge branch 'graph' into staging
      merge branch 'more-warning-flags' into staging and fix conflicts
      merge branch 'no-semantic-h' into staging and fix conflicts
      Merge branch 'Wcontext-default' into staging
      Add test cases to validation/context.c for the Linux __cond_lock ma=
cro
      Merge branch 'context-test-cases-for-cond-lock' into josh
      Rename test case bad-assignement.c to bad-assignment.c, fixing the =
typo.
      Stop building and installing libsparse.so

Josh Triplett and Pavel Roskin (1):
      Recognize and ignore __alias__ and __visibility__

Pavel Roskin (4):
      Compile sparse executable under it's own name, not as "check"
      Add support for __builtin_strpbrk()
      Typo fixes
      Install cgcc on "make install", refactor installation code

Known issue with this release:

* Sparse does not produce the expected set of warnings for several of the=

  validation programs, included in the sparse source in the directory
  validation/ .  Some scripts should provoke warnings but don't, and othe=
rs
  provoke warnings they shouldn't.


I've also put up a sparse website, at
<http://kernel.org/pub/linux/kernel/people/josh/sparse/>.  This site will=

include news and updates about sparse (including release announcements),
information on obtaining sparse, and documentation about sparse.  This ne=
w
website uses ikiwiki <http://ikiwiki.kitenet.net/>, by Joey Hess, and the=

ikiwiki Git backend.  I plan to move the underlying Git repository to
kernel.org as soon as I get ikiwiki and its dependencies installed on
master.kernel.org.

- Josh Triplett


--------------enigEAEB546D91651AA04C05A1F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUCKKGJuZRtD+evsRAhSyAJ4qTWIXotHSsCsTeqi60TUtH9G/mgCfYhRn
UKqEI+8A3hlJ4YGxianFBc4=
=o+kw
-----END PGP SIGNATURE-----

--------------enigEAEB546D91651AA04C05A1F0--
