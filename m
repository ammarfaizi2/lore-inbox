Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbVKQGgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbVKQGgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 01:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVKQGgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 01:36:53 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38788 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932618AbVKQGgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 01:36:52 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 0.99.9j aka 1.0rc3
cc: linux-kernel@vger.kernel.org
Date: Wed, 16 Nov 2005 22:36:51 -0800
Message-ID: <7vfypvzsos.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GIT 0.99.9j aka 1.0rc3 is found at usual places.

Notable change since 1.0rc2 are:

 - RPM packages has been split a bit differently [H. Peter
   Anvin].  Simon Richter asked me not to muck with debian
   packaging, so I take that Simon volunteered to update things
   to match what happened to RPM side.

 - On platforms and filesystems that can handle symlinks, you
   can now force symbolic refs by configuration item
   core.symrefsonly [Johannes Schindelin].

 - http-fetch is less leaky [Petr Baudis, Nick Hengeveld].

 - fsck-objects and refs tracking uses much less memory [Sergey
   Vlasov].

 - git wrapper is rewritten in C [Andreas Ericsson].

 - diff piped to patch inside a single repository is made binary
   safe [me]


There was a discussion to always use symrefs for .git/HEAD; this
will _not_ happen before 1.0.  It breaks too many exiting tools
without giving them enough advance notice.

The proposed updates branch has a couple of topics I consider
1.0 material.

 - git-log --since="two weeks ago", without using GNU date [Linus]
 - git-rebase to use "diff-piped-to-patch" [me]
 - git-branch -f to forcibly reset branch head [me]


Here is the shortlog.

Alecs King:
      Documentation/git-log.txt: trivial typo fix.

Andreas Ericsson:
      git-daemon: --inetd implies --syslog
      C implementation of the 'git' program, take two.
      Update git(7) man-page for the C wrapper.
      git --help COMMAND brings up the git-COMMAND man-page.
      daemon.c: fix arg parsing bugs

H. Peter Anvin:
      git-core-foo -> git-foo, except the core package

Johannes Schindelin:
      Add config variable core.symrefsonly
      Fix tests with new git in C
      Give python a chance to find "backported" modules

Jonas Fonseca:
      Fix git(1) link to git-index-pack

Junio C Hamano:
      Documentation: do not blindly run 'cat' .git/HEAD, or echo into it.
      diff: make default rename detection limit configurable.
      sha1_file.c::add_packed_git(): fix type mismatch.
      git wrapper: basic fixes.
      git-apply: fail if a patch cannot be applied.
      git-am: --resolved.
      apply: allow-binary-replacement.
      diff: --full-index
      tests: binary diff application.

Kevin Geiss:
      git-cvsexportcommit.perl: Fix usage() output.
      git-cvsexportcommit.perl: use getopts to get binary flags
      git-cvsexportcommit.perl: exit with non-0 status if patch fails.
      git-cvsexportcommit.perl: fix typos in output

Linus Torvalds:
      Disallow empty pattern in "git grep"

Lukas Sandström:
      Fix llist_sorted_difference_inplace in git-pack-redundant

Pavel Roskin:
      symref support for import scripts

Petr Baudis:
      Fix bunch of fd leaks in http-fetch

Sergey Vlasov:
      git-fsck-objects: Free tree entries after use
      Rework object refs tracking to reduce memory usage


