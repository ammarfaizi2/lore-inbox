Return-Path: <linux-kernel-owner+w=401wt.eu-S1030440AbXALCoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbXALCoD (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbXALCoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:44:03 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42906 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXALCoA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:44:00 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: What's in git.git and announcing GIT v1.5.0-rc1
cc: linux-kernel@vger.kernel.org
X-maint-at: 6534141151f7fd4334f62827d9234acf3974ca4d
X-master-at: ba70de01bb0c8a08135b63ace183bd3f4b149d9e
Date: Thu, 11 Jan 2007 18:43:53 -0800
Message-ID: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tip of 'master' branch is tagged as v1.5.0-rc1; this means a
few things:

 - The focus is shifted to stabilize 'master'.  Fixes to what
   are already there are very much appreciated.

 - I'll change my $PATH to use the 'master' version, not 'next',
   for my own use until v1.5.0 final.  I ask people who usually
   follow 'next' to do the same so that we can catch breakages
   on 'master'.

 - No new features nor major changes, whether they have been
   cooking in 'next' or not, will be merged to 'master' until
   v1.5.0 final.  I might drop patches on the floor that are not
   meant for 'master', although I intend to try hard to keep up
   with whatever the list comes up with.

Tonight's update merges a handful remaining topics from 'next',
along with fixes and updates directly applied to 'master'.


* The 'master' branch has these since the last announcement.

   Alex Riesen (1):
      Speed-up recursive by flushing index only once for all entries

   Eric Wong (1):
      Avoid errors and warnings when attempting to do I/O on zero bytes

   Johannes Schindelin (2):
      Sanitize for_each_reflog_ent()
      Fix t1410 for core.filemode==false

   Junio C Hamano (20):
      Move initialization of log_all_ref_updates
      Introduce is_bare_repository() and core.bare configuration variable
      git-fetch: allow updating the current branch in a bare repository.
      git-status: show detached HEAD
      Detached HEAD (experimental)
      git-checkout: do not warn detaching HEAD when it is already detached.
      git-checkout: rewording comments regarding detached HEAD.
      git-checkout: safety when coming back from the detached HEAD state.
      git-checkout: fix branch name output from the command
      git-checkout: safety check for detached HEAD checks existing refs
      git-checkout: handle local changes sanely when detaching HEAD
      Makefile: remove $foo when $foo.exe is built/installed.
      merge-recursive: do not use on-file index when not needed.
      Document git-init
      index-pack: write-or-die instead of unchecked write-in-full.
      config-set: check write-in-full returns in set_multivar
      git-rm: do not fail on already removed file.
      git-status: wording update to deal with deleted files.
      plug a few leaks in revision walking used in describe.
      GIT v1.5.0-rc1

   Jürgen Rühle (2):
      send-email: work around double encoding of in-body From field.
      Provide better feedback for the untracked only case in status output

   Lars Hjemli (1):
      git-branch: show detached HEAD

   Linus Torvalds (3):
      write-cache: do not leak the serialized cache-tree data.
      write_in_full: really write in full or return error on disk full.
      Better error messages for corrupt databases

   Nicolas Pitre (1):
      Add git-init documentation.

   Shawn O. Pearce (4):
      Don't save the commit buffer in git-describe.
      Make git-describe a builtin.
      Disallow working directory commands in a bare repository.
      Chose better tag names in git-describe after merges.


