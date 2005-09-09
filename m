Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVIIWjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVIIWjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVIIWjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:39:05 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:17293 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932608AbVIIWjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:39:04 -0400
Date: Sat, 10 Sep 2005 00:40:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [GIT PATCHES] kbuild: full dependency check on asm-offset.h
Message-ID: <20050909224029.GA8984@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Seems that first attempt sending out this patchset went wrong..]

The following 12 patches introduces full dependency tracking on the
generated asm-offsets.h file.
It also consolidate the rules required to build the asm-offsets.h file
in a new file named Kbuild in the top-level directory.

Introducing this consolidated method called for a consistent naming of
the file across all architectures, therefore this patchset touches a lot
of .S files all over the place but with trivial changes only.

A few architectures did not use asm-offsets.h so they got a dymmy
asm-offsets.c file - to remind them and to avoid breaking the build.

The concept was presented at linux-arch yesterday with no objections
and I request it to be applied to 2.6.14.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

I will try to follow-up on this mail with the patches to lkml.

	Sam
