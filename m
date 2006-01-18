Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWARGun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWARGun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWARGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:50:40 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:54937 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1751366AbWARGuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:50:37 -0500
Date: Wed, 18 Jan 2006 14:48:28 +0800
Message-Id: <200601180648.k0I6mS8N005815@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Title: [PATCH 0/13] autofs4 - various cleanups, updates and bug fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first set of patches for autofs in moving toward a
kernel <-> userspace communication protocol update.

The changes implemented in the patch set are:

1) lookup-cleanup - cleanup of whitespace and formating changes.
2) readdir-cleanup - changes readdir routines to use the cursor
   based routines in libfs.c.
3) failed-lookup - fix stale dentrys stopping mounts.
4) expire-cleanup - change return values and names of two functions
   to aid code readability.
5) expire-traversal-cleanup - simplify expire by adapting it to
   use the "next_entry" function from namespace.c.
6) expire-tree-false-negative - fix an expire case which returns
   busy on tree mounts when they are not.
7) expire-not-busy-only - alter expire semantics to match that
   needed for a rework of autofs direct mounts.
8) remove-update_atime - remove update of atime in favour of
   letting the VFS update it.
9) add-show_options - add show_options method to display autofs4
   mount options in the proc filesystem.
10) waitq-cleanup - whitespace cleanup of waitq.c
11) rename-simple_empty_nolock - rename function according to
   kernel conventions.
12) may_umount-to-boolean - change may_umount* functions to
  boolean to aid code readability.

