Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVLDJVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVLDJVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 04:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVLDJVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 04:21:15 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26579 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751332AbVLDJVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 04:21:15 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] GIT 0.99.9l aka 1.0rc4
Date: Sun, 04 Dec 2005 01:21:13 -0800
Message-ID: <7vy831p69i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GIT 0.99.9l aka 1.0rc4 is found at a new location.

RPM
	http://kernel.org:/pub/software/git/RPMS/

Debian [*1*]
	http://kernel.org:/pub/software/git/debian/

This is mostly fixes, with some improvements.  As I said on the
git list earlier, no more major feature/semantics changes after
this is expected until 1.0.

Highlights are:

 - After a conflicting merge, the index file is left unmerged.
   As before, after such conflicting merge, "git diff" can be
   used to view the differences between the half-merged file and
   "our" branch version by default, but now you can say "git
   diff --base" and "git diff --theirs" to view the differences
   since the merge-base version and the other branch's version,
   respectively.

 - git-daemon and other git native protocols allow user-relative
   paths (e.g. git://host/~user/repo).  git-daemon's path
   whitelist check used to be done with the realpath (i.e. what
   getcwd() returns) in 0.99.9k and later "master" branch
   versions, but it was changed back to check against what the
   requester asked.

 - The commands have been future-proofed so that they refuse to
   operate on repositories from future unknown versions, to
   avoid corrupting them by mistake.

 - Bisect can take pathspec to cut down the number of revisions
   that need to be tested.

 - Many low-level commands have been updated to work better from
   subdirectories (much of the barebone porcelain wrappers that
   deal with the whole repository or the whole tree still need
   to be run from the top level, though).

 - Merge used to fail when it removed a file (fixed).

 - When only GIT_OBJECT_DIRECTORY was exported things broke
   since 0.99.9k (fixed).

 - Comes with updated gitk.

[Footnote]

*1* It appears Debian finally has an official maintainer, so I
am inclined to stop building and supplying the debs starting
from the next version --- one less thing to worry about for me.
I hope the Debian side splits the packages along the same line
as we do RPMs.

