Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTBSRvK>; Wed, 19 Feb 2003 12:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTBSRvK>; Wed, 19 Feb 2003 12:51:10 -0500
Received: from ashi.footprints.net ([204.239.179.1]:62215 "EHLO
	ashi.FootPrints.net") by vger.kernel.org with ESMTP
	id <S261302AbTBSRvJ>; Wed, 19 Feb 2003 12:51:09 -0500
Date: Wed, 19 Feb 2003 10:01:11 -0800 (PST)
From: Kaz Kylheku <kaz@ashi.footprints.net>
To: linux-kernel@vger.kernel.org
Subject: Re: re: openbkweb-0.0
Message-ID: <Pine.LNX.4.44.0302191000240.8499-100000@ashi.FootPrints.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have developed a version control system based on CVS that supports
real, mergeable directory structure versioning, and other cool
features, like symbolic links and simplified branching and merging
commands (no messing around with CVS tags to track merges).

Distributed version control it ain't, but it has a way of importing
snapshots onto a branch. The importing feature automatically figures
renames, including tricky cases where files are moved, and symbolic
links follow them, while being themselves moved or renamed.

A snapshot doesn't give you the detailed change history of a true
changeset, but on the plus side, it can be produced by people who
don't use your version control system.

Meta-CVS is stable software that just works. It's less than 6000 lines
of Common Lisp, which uses CVS as a subprocess as necessary, without
requiring any modifications to that software whatsoever. I have done
everything possible to create a better version control system without
starting completely from scratch, and without introducing a great deal
of risk into an existing system.

CVS still has a few fault-tolerance and performance issues. For
instance, it would be nice to have atomic commits and faster tagging.
In the cvs-bug list I propoposed a simple, low-risk design for atomic
commits, which one of the CVS maintainers is now running with. So we
may see an atomic CVS before long.

