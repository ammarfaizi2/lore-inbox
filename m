Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVASSyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVASSyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVASSyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:54:46 -0500
Received: from ip67-155-213-211.z213-155-67.customer.algx.net ([67.155.213.211]:37418
	"EHLO noteshub.teal.com") by vger.kernel.org with ESMTP
	id S261846AbVASSym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:54:42 -0500
Subject: Kernel Panic in pipe_poll
To: linux-kernel@vger.kernel.org
Message-ID: <OF20680AAF.E95A5CE7-ON85256F8E.0066BF8F@teal.com>
From: Jeff.Fellin@rflelect.com
Date: Wed, 19 Jan 2005 13:53:13 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two questions:
1) I have tried to find buglists for version of Linux after 2.4.18, and
have been unable to locate any. Can someone supply me a URL
   to find the bug list archives?

2) I am running a 2.4.18 Linux kernel on a Power PC 405GP processor. The
application makes extensive use of named pipes
   for communication between processes. Occassionally, the system panics in
pipe_poll  when getting the inode pointer
   from the file pointer at the statement: filp->f_dentry->d_inode;. The
value of f_dentry is NULL, along with the value of vfsmnt.
   This looks as if the code had called fput(filp) when the reference count
was 1 so the struct file* had entries cleared. However,
   by adding some printk's, I have observed the value of f_count, is 1 so
the pointers should be valid.
   The kernel panic is an Oops of dereferencing   a NULL pointer.

   Has this problem been seen before?
      If so, could you point me to information on how the problem was
corrected or which Linux  release the problem is fixed in.
      If no one has seen this problem any ideas on how to determine how
these fields get NULL'ed would be appreciated.



Jeff Fellin
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327

