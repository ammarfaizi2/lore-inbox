Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbUKFTSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUKFTSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUKFTSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:18:42 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:39151 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261444AbUKFTSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:18:40 -0500
Date: Sat, 6 Nov 2004 14:15:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: balance_pgdat(): where is total_scanned ever updated?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Message-ID: <200411061418_MC3-1-8E17-8B6C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version is 2.6.9, but I see no updates to this function in BK-current.
How is total_scanned ever updated?  AFAICT it is always zero.

In mm/vmscan.c:balance_pgdat(), there are these references to total_scanned
(missing whitepace indicated by "^"):


 977:        int total_scanned, total_reclaimed;

 983:        total_scanned = 0;

1076:                        if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
1077:                            total_scanned > total_reclaimed+total_reclaimed/2)
                                                               ^ ^             ^ ^

1088:                if (total_scanned && priority < DEF_PRIORITY - 2)


Could this be part of the problems with reclaim?  Or have I missed something?


--Chuck Ebbert  06-Nov-04  14:15:21
