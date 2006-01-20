Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWATImo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWATImo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWATImo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:42:44 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40320 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750735AbWATImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:42:42 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: What's in git.git
cc: linux-kernel@vger.kernel.org
Date: Fri, 20 Jan 2006 00:42:40 -0800
Message-ID: <7vvewfz3wf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now 1.1.4 is out, here is a summary of what are not there but
already merged to the "master" branch (i.e. 1.2.0 material).

Build and Environment issues:

      Makefile: add 'strip' target
      Fix the installation location.
      Allow building of RPM from interim snapshot.
      Exec git programs without using PATH (Michal Ostrowski).
      Disable USE_SYMLINK_HEAD by default (Pavel Roskin)

CVS:

      git-cvsimport: Add -A <author-conv-file> option (Andreas).
      cvsimport: ease migration from CVSROOT/users format


Pushes and Pulls:

      git-push: avoid falling back on pushing "matching" refs.
      git-push: fix --tags and document it.
      clone: --naked option.
      Add --keep option to keep downloaded packs to git-fetch (Tom Prince).
      Fix generation of "humanish" part of source repo (Uwe Zeisberger)


Usability Enhancements:

      git-describe: default to HEAD

      Documentation: show-branch.
      show-branch: make the current branch and merge commits stand out.
      show-branch: --current includes the current branch.
      show-branch: take default arguments from configuration file.

      octopus: allow criss-cross and clarify the message when it rejects
      octopus: allow manual resolve on the last round.

      checkout: automerge local changes while switching branches.
      checkout: merge local modifications while switching branches.
      checkout: show dirty state upon switching branches.

      format-patch: always --mbox and show sane Date:

----------------------------------------------------------------

These are still cooking in "pu" branch.

Build and Environment:

      Makefile: do not assume lack of IPV6 means no sockaddr_storage.
      fsck-objects: support platforms without d_ino in struct dirent.
      DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN

      * These are for the latest Cygwin builds.

Documentation:

      New Tutorial (J. Bruce Fields)

      * Waiting for updates after the last round of comments.

Subproject:

      read-tree: --prefix=<path>/ option.
      write-tree: --prefix=<path>/ and --exclude=<prefix>/.
      commit-tree: --bind <sha1> <path>/ option.

      * Basic design has been outlined, and read-tree/write-tree
        are probably safe to push out, but commit objects that
        contain "bind" lines are unsafe until fsck-objects and
        rev-list are updated.

Annotate:

      rev-list: stop when the file disappears (Linus)

      * I've only taken a cursory look at this patch.

