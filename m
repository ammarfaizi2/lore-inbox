Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWBSI4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWBSI4p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 03:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWBSI4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 03:56:44 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14546 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932364AbWBSI4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 03:56:44 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.2.2
cc: linux-kernel@vger.kernel.org
Date: Sun, 19 Feb 2006 00:56:42 -0800
Message-ID: <7v4q2vload.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.2.2 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.2.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.2-1.$arch.rpm	(RPM)

Carl Worth fixed a longstanding annoyance of failed clone
leaving a half-built cloned directory.  Contributions from
people new to the list are much appreciated.  Long timers have
just leaned to live with these inconveniences, but I expect such
rough edges will be rounded out quickly as we gain more wider
user base.

The much talked about pack performance enhancement is not in
this release.  In principle, 1.2.X series are supposed to be
bugfix only, so I can justifiably be lazy and keep things that
way, but we _could_ argue that the old pack-object had a
performance bug ;-).  

We will decide what to do after it hits the master branch.  I
think pack-object is important enough to be conservative about,
but at the same time its performance is veriy critical for the
public git server, so as it proves stable we probably would want
to have it on kernel.org.

----------------------------------------------------------------

Changes since v1.2.1 are as follows:

Carl Worth:
      Trap exit to clean up created directory if clone fails.
      Abstract test_create_repo out for use in tests.
      Prevent git-upload-pack segfault if object cannot be found

Eric Wong:
      archimport: remove files from the index before adding/updating

Jonas Fonseca:
      git-rev-parse: Fix --short= option parsing
      Document --short and --git-dir in git-rev-parse(1)

Martin Mares:
      Fix retries in git-cvsimport

Shawn Pearce:
      Make git-reset delete empty directories


