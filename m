Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWEUTBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWEUTBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWEUTBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:01:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49058 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964905AbWEUTBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:01:38 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: What's in git.git
cc: linux-kernel@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: 9e848163eda686093f689c25cfa9937ed2a9fdf8
Date: Sun, 21 May 2006 12:01:36 -0700
Message-ID: <7vzmhbgq27.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is sent to the kernel list as well, because I suspect
  Eric's quiltimport matches the audience there and it deserves
  a bit more exposure.  "What's in git.git" is sometimes more
  important and significant than [ANNOUNCE] messages, and this
  is such a time. ]

* The 'maint' branch has these fixes since the last announcement.

Elrond:
      git-cvsimport: Handle "Removed" from pserver

Fredrik Kuivinen:
      Update the documentation for git-merge-base

Junio C Hamano:
      merge-base: Clarify the comments on post processing.


* The 'master' branch has these since the last announcement, in
  addition to the above.

  - git-quiltimport (Eric W. Biederman)

    This will probably see more enhancements over time taking
    inputs from real quilt users.

  - use config file to store remotes information (Johannes Schindelin)

  - pack-objects further 15% improvements (Nicolas Pitre)

  - "diff --check" (Johannes Schindelin)

  - "git apply --cached"

  - read-tree -m -u: do not overwrite or remove untracked working tree files.

  - more built-in commands (Linus, Lukas, Timo and me)
  - commit: allow --pretty= args to be abbreviated (Eric Wong)
  - Other minor fixes to "git apply", "git diff". 

  - many cleanups from Sean Estabrooks, Shawn Pearce, 
      Remove unnecessary local in get_ref_sha1.
      Reference git-check-ref-format in git-branch.
      Elaborate on why ':' is a bad idea in a ref name.

  Also Tilman Sauerbeck twisted my arm sufficiently enough that
  I incorporated some of what I use to generate html/man pages
  automatically every time I update "master" in the main
  Makefile; so if I do not forget to update my release script,
  there will be html/man documentation tarballs next to the
  usual source tarball release when 1.4.0 release is done.


* The 'next' branch, in addition, has these.

 - built-in "git add/rm" (Linus)

   Will merge to "master" shortly, unless somebody finds
   breakage soon enough.

 - built-in "git format-patch" (Johannes Schindelin) 

   Will merge to "master" shortly, unless somebody finds
   breakage soon enough.

 - "git tar-tree --remote"

   This change itself is low-impact and while it is not a
   substitute for true shallow/lazy clone people may find it
   useful in other scenarios.  I dunno.

 - cache-tree with read-tree/write-tree --prefix

   I haven't made any progress on this one, but haven't been
   bitten by it either, so it is a good sign.


* The 'pu' branch, in addition, has these.

Eric Wong:
      git-svn: ignore expansion of svn:keywords [test patch]

Sean Estabrooks:
      Remove possible segfault in http-fetch.

Shawn Pearce:
      Improve abstraction of ref lock/write.
      Convert update-ref to use ref_lock API.
      Log ref updates to logs/refs/<ref>
      Support 'master@2 hours ago' syntax
      Fix ref log parsing so it works properly.
      General ref log reading improvements.
      Added logs/ directory to repository layout.
      Force writing ref if it doesn't exist.
      Log ref updates made by fetch.
      Change 'master@noon' syntax to 'master@{noon}'.
      Correct force_write bug in refs.c
      Change order of -m option to update-ref.
      Include ref log detail in commit, reset, etc.
      Create/delete branch ref logs.
      Enable ref log creation in git checkout -b.


