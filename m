Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUJNWvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUJNWvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUJNWvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:51:24 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:46555 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S268126AbUJNWtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:49:17 -0400
Date: Fri, 15 Oct 2004 01:49:15 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Cc: Bjoern Brandenburg <askadar@cs.tu-berlin.de>
Subject: Re: OOPS in ReiserFS
Message-ID: <20041014224915.GD31434@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Bjoern Brandenburg <askadar@cs.tu-berlin.de>
References: <20041014223154.GA12089@conde.cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014223154.GA12089@conde.cs.tu-berlin.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 12:31:54AM +0200, Bjoern Brandenburg wrote:
> Hi gurus, 
> I encountered an oops in ReiserFS. I hope I can give you some useful
> information (my first attempt a reporting a kernel-oops). Please cc me if you
> have questions, I don't usually follow lkml.
> 
> Thank you for your time,
> Bjoern
> 
> [1.] 
> The ReiserFS filesystem locked up with an oops after finding a corrupt
> partition. Hardware seems to be ok, at least I didn't have problems before.
...
> [4.]
> [askadar@invisible-university ~]$ cat /proc/version
> Linux version 2.6.8.1 (root@earth) (gcc version 3.4.1) #1 SMP Sun Aug 22 16:44:06 PDT 2004
> 
> [5.]
> Oct 15 00:51:49 invisible-university ReiserFS: warning: is_tree_node: node
> level 3 does not match to the expected one 1
> Oct 15 00:51:49 invisible-university ReiserFS: hde5: warning: vs-5150:
> search_by_key: invalid format found in block 1179648. Fsck?

I got these, too, when I was using gcc-3.4.1 to compile the 2.6.8-rc2 kernel.
Using gcc-2.95.3 made all of the Oopses and other mysterious crashes disappear.

So, if you can reproduce these with gcc-2.95.3 it would be nice.

Aug  5 12:09:09 safari kernel: ReiserFS: hda6: warning: vs-5150: search_by_key: invalid format found in block 3408369. Fsck?
Aug  5 12:09:09 safari kernel: ReiserFS: hda6: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [1419453 1419466 0x0 SD]
Aug  5 12:09:21 safari kernel: ReiserFS: warning: is_tree_node: node level 8 does not match to the expected one 2
Aug  5 12:09:21 safari kernel: ReiserFS: hda6: warning: vs-5150: search_by_key: invalid format found in block 3408369. Fsck?

(And of course, fsck said all is fine.)

> Oct 15 00:51:49 invisible-university ReiserFS: hde5: warning: vs-13050:
> reiserfs_update_sd: i/o failure occurred trying to update [1154 1504 0x0
> SD] stat data
> Oct 15 00:51:49 invisible-university ReiserFS: warning: is_tree_node: node
> level 3 does not match to the expected one 1
> Oct 15 00:51:49 invisible-university ReiserFS: hde5: warning: vs-5150:
> search_by_key: invalid format found in block 1179648. Fsck?
...

-- 

