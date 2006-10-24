Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752087AbWJXG1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbWJXG1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 02:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWJXG1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 02:27:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49071 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752075AbWJXG1I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 02:27:08 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.3.2
cc: linux-kernel@vger.kernel.org
Date: Mon, 23 Oct 2006 23:27:07 -0700
Message-ID: <7vd58irzyc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.3.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.2-1.$arch.rpm	(RPM)

This is primarily to fix two rather embarrasing breakage
discovered post 1.4.3.1 release.

 - The pager change to default to LESS=FRS exposed problem with less
   that switches to alternate screen, shows its output and then switches
   back immediately from the alternate screen afterwards -- which means
   the user would not have a chance to see _anything_.

 - Older upload-pack protocol clients did not pass host= and recent
   git-daemon change to support virtual hosting did not handle this
   correctly (although it attempted to do so, the check was borked).

----------------------------------------------------------------

Changes since v1.4.3.1 are as follows:

Alexandre Julliard (1):
      prune-packed: Fix uninitialized variable.

J. Bruce Fields (1):
      Make prune also run prune-packed

Jakub Narebski (2):
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
      gitweb: Do not esc_html $basedir argument to git_print_tree_entry

Jim Meyering (2):
      git-clone: honor --quiet
      xdiff/xemit.c (xdl_find_func): Elide trailing white space in a context header.

Junio C Hamano (2):
      pager: default to LESS=FRSX not LESS=FRS
      daemon: do not die on older clients.

Karl Hasselstrøm (1):
      git-vc: better installation instructions

Lars Hjemli (1):
      Fix usagestring for git-branch

Petr Baudis (1):
      gitweb: Fix setting $/ in parse_commit()

Rene Scharfe (1):
      git-merge: show usage if run without arguments

Santi Béjar (1):
      Documentation for the [remote] config


