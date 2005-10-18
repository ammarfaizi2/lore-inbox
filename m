Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVJRAxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVJRAxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVJRAxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:53:22 -0400
Received: from american.megatrends.com ([155.229.80.3]:24074 "EHLO
	american.megatrends.com") by vger.kernel.org with ESMTP
	id S1751433AbVJRAxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:53:21 -0400
Message-ID: <3225AF1B8CBF83459982D4987F1549CE055EE5@fre-ops.us.megatrends.com>
From: Srikumar Subramanian <SrikumarS@ami.com>
To: linux-kernel@vger.kernel.org
Cc: Srikumar Subramanian <SrikumarS@ami.com>,
       Prabhakar Krishnan <kpkar@ami.com>
Subject: Kernel Panic in XFS ACL
Date: Mon, 17 Oct 2005 20:55:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am using FC3: kernel 2.6.9-1.667smp

I create a base directory (base/) with 10 access ACL and 10 default ACL. The
file system size is 2 GB. Under base/, i have create lot of subdir,
sub-subdirs, and files (each 1KB size).  

The idea is to test the stability of XFS with ACL.

During the test, there is no problem in inheriting acl from parent
directory. 

But when the XFS file system goes out of space, it stops with a panic. It is
reproducible consistently.

I have typein the kernel dump:
EIP at 0060 :[44bf9bbc]
EIP at xfs_ail_insert
xfs_trans_update_ail
xfs_trans_chunk_committed
xfs_trans_committed
xlog_state_do_callback
xlog_iodone
...
...

The same test went good without any panic in XFS 1.2 (Kernel 2.4.20)

Any kernel patch is much appreciated.

Please CC me in your reply.

Thanks & Regards,
Srikumar Subramanian

