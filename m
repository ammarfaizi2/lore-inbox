Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269200AbUI2XcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbUI2XcC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUI2X3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:29:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:47232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269207AbUI2X3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:29:18 -0400
Date: Wed, 29 Sep 2004 16:29:08 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-aio@kvack.org>
cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: OSDL aio-stress results on latest kernels show buffered random read
 issue
Message-ID: <Pine.LNX.4.33.0409291621170.4332-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

I am running aio-stress on the most recent kernels and have
found that on linux-2.6.8, 2.6.9-rc2 and 2.6.9-rc2-mm4 the
performance of buffered random reads is poor compared to the
buffered random writes:

               2.6.8      2.6.9-rc2     2.6.9-rc2-mm4
             --------------------------------------------
random write 35.66 MB/s   34.80 MB/s    29.89 MB/s
random read   7.69 MB/s    7.50 MB/s     7.68 MB/s

** 2CPU hosts with striped Megaraid. 1G RAM. 4G File.


This shows up on our 4CPU host as well. (striped AACRAID.4G
RAM. 8G File):
             2.6.9-rc2     2.6.9-rc2-mm4   2.6.9-rc2-mm1
             -------------------------------------------
random write 31.36 MB/s     18.92 MB/s      18.97 MB/s
random read  11.13 MB/s      9.74 MB/s      11.05 MB/s


There seems to be an issue with the reads.  Usually, reads
should be at least as fast as writes of the same type.

Also, there seems to be a substantial drop-off in the performance
of AIO buffered-random writes in the mm kernels. (14% on 2CPU,
40% on 4CPU)

Regards;
Judith Lebzelter
OSDL


