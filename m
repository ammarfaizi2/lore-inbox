Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFCWzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFCWzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFCWzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:55:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25775 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261165AbVFCWzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:55:46 -0400
Date: Fri, 3 Jun 2005 17:55:44 -0500
From: Jack Steiner <steiner@sgi.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Hang in sched_balance_self()
Message-ID: <20050603225544.GA8499@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick -

The latest 2.6.12-rc5-mm2 tree fails to boot on some of the 64p
SGI systems. The system hangs immediately after printing:

	...
	Inode-cache hash table entries: 8388608 (order: 12, 67108864 bytes)
	Mount-cache hash table entries: 1024
	Boot processor id 0x0/0x0
	Brought up 64 CPUs
	Total of 64 processors activated (118415.36 BogoMIPS).


I have isolated the failure to cpu 0 hanging in sched_balance_self() during
a fork (or clone).  The "while" loop at the end of function never 
terminates, ie. sd is never NULL.

Is this a problem that you have seen before. If not, I'll do some
more digging & isolate the problem.


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


