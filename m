Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRHWR1B>; Thu, 23 Aug 2001 13:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRHWR0v>; Thu, 23 Aug 2001 13:26:51 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:55231 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268017AbRHWR0q>; Thu, 23 Aug 2001 13:26:46 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F35@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: The cause of the "VM" performance problem with 2.4.X
Date: Thu, 23 Aug 2001 12:26:40 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a "mkfs" on a "md" of 3 8-disk "md"s (24 disk md).  So no
lock contention, and only one "dev" to match, right?  [Try to
avoid the problem.]

getblk was holding the lru_list_lock lock 86% of the time.

Was averaging about 25,000 blocks/sec to the disks (vmstat),
but it was often 200,000 over 2 seconds, then 5 seconds idle,
etc.  Disk lights didn't come on much (but they all blinked
nicely in sync).

I'll try your patch out and run individual disks again.

Kevin
