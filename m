Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVBCK3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVBCK3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVBCK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:29:49 -0500
Received: from web51602.mail.yahoo.com ([206.190.38.207]:58706 "HELO
	web51602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262926AbVBCK3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:29:21 -0500
Message-ID: <20050203102915.61551.qmail@web51602.mail.yahoo.com>
Date: Thu, 3 Feb 2005 11:29:15 +0100 (CET)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: 2.6.10: kswapd spins like crazy
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently upgraded my desktop from 2.4.28 to
2.6.10. Even under moderate memory pressure kswapd
regularly eats almost all available cpu time 
whenever there is a little more IO throughput,
like copying large files. The system is extremely
sluggish during this. The system load goes up to 
7.5 or more.
 
This is a Pentium3-866 with 768MB RAM, 2x1GB 
swap partitions, vanilla 2.6.10. The strange 
behaviour starts at about 200 MB of swap in use.
2.4.28 masters the same workload without any
problems.

vmstat:
procs -----------memory---------- 
 r  b   swpd   free   buff  cache
 6  1 428012   4868  33236 347184
---swap-- -----io---- --system-- ----cpu----
 si   so    bi    bo   in    cs us sy id wa
 10    7   147   120  108   111 19 10 68  3

Is there anything I can do to track this down?

Regards, 
Terje
