Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTLJLgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 06:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTLJLgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 06:36:45 -0500
Received: from [212.239.224.52] ([212.239.224.52]:62593 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262195AbTLJLgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 06:36:44 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test11] reiserfs io failures
Date: Wed, 10 Dec 2003 12:35:25 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101235.25596.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today I discovered this in my syslogs, after something strange 
happening to XFree86 (hung at startup, then dumped me back to the console)

is_leaf: free space seems wrong: level=1, nr_items=41, free_space=65224 rdkey 
vs-5150: search_by_key: invalid format found in block 283191. Fsck?
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [11 12795 0x0 SD]
is_leaf: free space seems wrong: level=1, nr_items=41, free_space=65224 rdkey 
vs-5150: search_by_key: invalid format found in block 283191. Fsck?
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [11 12798 0x0 SD]

I've never seen these before, and I've been digging through my syslogs but am 
unable to find any other references of this.
Does this mean the disk is dying? Or just the filesystem is corrupt? 
Unfortunately, I'm not able to rebuild the tree at this time because I 
haven't got a 'rescue' disk with me and the errors are on my root partition...

Any other pointers?

Thanks.

Jan
-- 
Remember:  Silly is a state of Mind, Stupid is a way of Life.
-- Dave Butler

