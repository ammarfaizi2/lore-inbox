Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVHOEfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVHOEfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 00:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVHOEfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 00:35:01 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:7490 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S1750833AbVHOEfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 00:35:00 -0400
Message-ID: <43001B44.3050205@google.com>
Date: Sun, 14 Aug 2005 21:34:12 -0700
From: Hareesh Nagarajan <hareesh@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com
Subject: [PATCH] [TRIVIAL] relayfs: remove comment on overwrite mode
Content-Type: multipart/mixed;
 boundary="------------020007020909030703080107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020007020909030703080107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

The overwrite arg has been removed from the relay_subbufs_consumed() 
(since it has been removed from relayfs altogether) so the comment 
preceding the function must go.

Thanks,

Hareesh

--------------020007020909030703080107
Content-Type: text/plain;
 name="relayfs-remove-overwrite-comment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="relayfs-remove-overwrite-comment.patch"

diff -ruN linux-akpm/fs/relayfs/relay.c linux/fs/relayfs/relay.c
--- linux-akpm/fs/relayfs/relay.c	2005-08-14 21:16:35.000000000 -0700
+++ linux/fs/relayfs/relay.c	2005-08-14 21:26:10.000000000 -0700
@@ -342,9 +342,6 @@
  *	Adds to the channel buffer's consumed sub-buffer count.
  *	subbufs_consumed should be the number of sub-buffers newly consumed,
  *	not the total consumed.
- *
- *	NOTE: kernel clients don't need to call this function if the channel
- *	mode is 'overwrite'.
  */
 void relay_subbufs_consumed(struct rchan *chan,
 			    unsigned int cpu,

--------------020007020909030703080107--
