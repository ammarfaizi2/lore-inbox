Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288655AbSATJDj>; Sun, 20 Jan 2002 04:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSATJDU>; Sun, 20 Jan 2002 04:03:20 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:17924
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288089AbSATJDM>; Sun, 20 Jan 2002 04:03:12 -0500
Date: Sun, 20 Jan 2002 04:04:03 -0500 (EST)
From: Shawn <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Possible Idea with filesystem buffering.
Message-ID: <Pine.LNX.4.40.0201200359520.503-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've noticed that XFS's filesystem has a separate pagebuf_daemon to handle
caching/buffering.

Why not make a kernel page/caching daemon for other filesystems to use
(kpagebufd) so that each filesystem can use a kernel daemon interface to
handle buffering and caching.

I found that XFS's buffering/caching significantly reduced I/O load on the
system (with riel's rmap11b + rml's preempt patches and Andre's IDE
patch).

But I've not been able to acheive the same speed results with ReiserFS :-(

Just as we have a filesystem (VFS) layer, why not have a buffering/caching
layer for the filesystems to use inconjunction with the VM?

Comments, suggestions, flames welcome ;)

Shawn.

