Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263236AbVCMG5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbVCMG5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 01:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbVCMG5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 01:57:07 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:20870 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S263236AbVCMG46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 01:56:58 -0500
Date: Sat, 12 Mar 2005 22:56:53 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: jfs-discussion@lists.sourceforge.net,
       Dave Kleikamp <shaggy@austin.ibm.com>, <nfs@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.Stanford.EDU>
Subject: [CHECKER] NFS on JFS doesn't sync all file system operations (NFS
 on JFS, 2.6.11)
Message-ID: <Pine.GSO.4.44.0503122250560.6688-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

FiSC found that at link operation and unlink operation on a NFS partion on
top of JFS are not sync'ed.   These warnings show up in JFS but not in
ext2, ext3, so I suspect it's a potential JFS problem.

cat /etc/exports shows:
/mnt/sbd0-export          localhost(rw,sync,no_subtree_check)
/mnt/sbd1-export          localhost(rw,sync,no_subtree_check)

test cases can be found at:

http://fisc.stanford.edu/bug17/crash.c
http://fisc.stanford.edu/bug17/crash-unlink.c

Thanks,
-Junfeng

