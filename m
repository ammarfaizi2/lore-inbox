Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUBYAUz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbUBYAUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:20:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:27026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262538AbUBYAUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:20:53 -0500
Date: Tue, 24 Feb 2004 16:20:52 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: reaim - 2.6.3-mm1 IO performance down.
Message-Id: <20040224162052.33895550.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Running the reaim 'new_fserver' workload, we now see a performance drop
on 2.6.3-mm1, ext3 filesystem

Kernel          JPM       Max Users     Percent change
inux-2.6.3      10347.87  172           0.0
2.6.3-rc3-mm1   9826.35   164           -5.07
2.6.3-mm1       8938.17   140   (run 1) -13.65
2.6.3-mm1       9100.39   136    (run 2)-12.08 

I have done some comparions graphs here, with readprofile data:
http://developer.osdl.org/cliffw/reaim/compares/r_comp/2.6.3_vs_mm1_r1/index.html
http://developer.osdl.org/cliffw/reaim/compares/r_comp/2.6.3_vs_mm1_r2/index.html

The interesting graph is the bottom one on the page, comparing client
run-time to number of children. The -mm1 kernel has a spike in run time, becoming
very noticealbe around 60-80 lusers.

kernel       Users 	JPM        Run Time
linux-2.6.3  60         10327.87   34.16 seconds
2.6.3-mm1    60         8279.75    42.61 seconds

Linux-2.6.3  80         10275.23   45.78 seconds
2.6.3-mm1    80         7841.31    59.99 seconds


For the same test on the same machine, results from 2.6.2-rc1-mm2 and 2.6.2-rc3-mm1
were within 1.0% of the linux-2.6.2 runs. So this is new. 

More data and tests if requested - are there some patch sets we should try reverting?
cliffw

-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
