Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVCLQnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVCLQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCLQnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:43:15 -0500
Received: from web8508.mail.in.yahoo.com ([202.43.219.170]:19301 "HELO
	web8508.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261958AbVCLQmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:42:36 -0500
Message-ID: <20050312164229.50537.qmail@web8508.mail.in.yahoo.com>
Date: Sat, 12 Mar 2005 16:42:29 +0000 (GMT)
From: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Subject: Implementation of Buffer Headers in Linux kernel
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few queries regarding the buffer headers in
linux. I a newbie so these queries may sound stupid to
linux gurus.

1. As per my understanding, block number in this
stucture corresponds to the block no of the data on a
logical device rather than on a physical device (hard
disk).

2. Why do we need pointer to a pointer for hash list ?
As per Maurice Bach book on OS, the hash list and free
list both are implemented as a circular, doubly link
list.

In the below, we have used a pointer for free list,
then why pointer to pointer has been used for hash
list.

struct buffer_head {
	/* First cache line: */
	struct buffer_head *b_next;	/* Hash queue list */
	struct buffer_head *b_next_free;/* lru/free list
linkage */
	struct buffer_head *b_prev_free;/* doubly linked list
of buffers */
	struct buffer_head **b_pprev;	/* doubly linked list
of hash-queue */
        // Rest part of sructure has been stripped
off.    
};


Can anyone clarify my these queries.

Thanks & Regards
Dinesh

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
