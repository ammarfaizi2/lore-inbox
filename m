Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313999AbSDFFnh>; Sat, 6 Apr 2002 00:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314000AbSDFFn1>; Sat, 6 Apr 2002 00:43:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59016 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313999AbSDFFnJ>;
	Sat, 6 Apr 2002 00:43:09 -0500
Date: Sat, 6 Apr 2002 00:43:08 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [WTF] ->setattr() locking changes
Message-ID: <Pine.GSO.4.21.0204060034240.28391-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	a) where the hell is update to Documentation/filesystems/* ?
	b) Dave, meet grep.  grep, meet Dave.  Have a happy relationship...

_Please_, grep before doing global changes.  Trivial search for
notify_change() would show several calls under ->i_sem.  E.g. one
in fs/nfsd/vfs.c.  Or in hpfs_unlink().

All other problems with BKL brigade aside, could you at least learn to
use basic tools?  It's not a rocket science, after all - you do global
interface changes, you need to do global search.

