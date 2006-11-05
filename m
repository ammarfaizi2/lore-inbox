Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965869AbWKEJBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965869AbWKEJBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 04:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965867AbWKEJBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 04:01:47 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32966 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965864AbWKEJBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 04:01:46 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.3.4
cc: linux-kernel@vger.kernel.org
Date: Sun, 05 Nov 2006 01:01:45 -0800
Message-ID: <7v1woiuv0m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.3.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.4-1.$arch.rpm	(RPM)

Among many minor fixes and documentation updates, this contains these
fixes:

 - revision traversal now treats --unpacked as commit filter,
   not traversal limiter.  If you have unpacked commits that are
   parents of packed ones which are in turn parents of commits
   that are unpacked, running rev-list starting at the latest
   unpacked commits used to _stop_ at the first packed commit
   and older unpacked commits were not shown.  With this update,
   the traversal does not stop at packed commits, and shows the
   older unpacked commits.  The updated semantics is easier to
   use with git-repack --unpacked.

 - In a repository configured for shared access, if the
   permission bits of existing directories are misconfigured
   (e.g. running repository commands as root by mistake), a
   codepath to create a new object failed with incorrect error
   message.  Fixed.

 - An earlier fix to cope with traditional-style patches that
   were generated with --unified=0 broke handling of creation
   and deletion diffs in git-apply.  Fixed.

----------------------------------------------------------------

Andy Parkins (2):
      Minor grammar fixes for git-diff-index.txt
      git-clone documentation didn't mention --origin as equivalent of -o

Christian Couder (3):
      Remove --syslog in git-daemon inetd documentation examples.
      Documentation: add upload-archive service to git-daemon.
      Documentation: add git in /etc/services.

Edgar Toernig (1):
      Use memmove instead of memcpy for overlapping areas

J. Bruce Fields (1):
      Documentation: updates to "Everyday GIT"

Jakub Narebski (3):
      diff-format.txt: Combined diff format documentation supplement
      diff-format.txt: Correct information about pathnames quoting in patch format
      gitweb: Check git base URLs before generating URL from it

Jan Harkes (1):
      Continue traversal when rev-list --unpacked finds a packed commit.

Johannes Schindelin (1):
      link_temp_to_file: call adjust_shared_perm() only when we created the directory

Junio C Hamano (9):
      Documentation: clarify refname disambiguation rules.
      combine-diff: a few more finishing touches.
      combine-diff: fix hunk_comment_line logic.
      combine-diff: honour --no-commit-id
      Surround "#define DEBUG 0" with "#ifndef DEBUG..#endif"
      quote.c: ensure the same quoting across platforms.
      revision traversal: --unpacked does not limit commit list anymore.
      link_temp_to_file: don't leave the path truncated on adjust_shared_perm failure
      apply: handle "traditional" creation/deletion diff correctly.

Nicolas Pitre (1):
      pack-objects doesn't create random pack names

Rene Scharfe (1):
      git-cherry: document limit and add diagram

Shawn O. Pearce (3):
      Use ULONG_MAX rather than implicit cast of -1.
      Remove SIMPLE_PROGRAMS and make git-daemon a normal program.
      Remove unsupported C99 style struct initializers in git-archive.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTaP6wMbZpPMRm5oRAvmYAJ9a58U9N7PaM7l7jyzw4MS4YiwjZACghgAO
LnuuiDIqaGGKJbkPJlS0Fto=
=9LbZ
-----END PGP SIGNATURE-----

