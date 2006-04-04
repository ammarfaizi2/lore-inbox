Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWDDWi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWDDWi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDDWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:38:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36511 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750831AbWDDWiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:38:25 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.2.5
cc: linux-kernel@vger.kernel.org
Date: Tue, 04 Apr 2006 15:38:24 -0700
Message-ID: <7vzmj155lr.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.2.5 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.5.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.5-1.$arch.rpm	(RPM)

This is primarily made to help Solaris folks who were bitten by
pack-objects (hence cloning from a repository hosted on Solaris)
broken by the progress-bar eye-candy.  People who follow the
"master" branch, and people who run 1.2.4 on platforms with BSD
signal semantics (which automatically restarts interrupted
read() upon signal) need not worry.

With the "master" branch work nearing 1.3.0, hopefully this will
be the last 1.2.X release.

----------------------------------------------------------------

Changes since v1.2.4 are as follows:

Jason Riedy:
      Use sigaction and SA_RESTART in read-tree.c; add option in Makefile.

Junio C Hamano:
      read-tree --aggressive: remove deleted entry from the working tree.
      tar-tree: file/dirmode fix.
      safe_fgets() - even more anal fgets()

Linus Torvalds:
      Fix Solaris stdio signal handling stupidities
      pack-objects: be incredibly anal about stdio semantics


