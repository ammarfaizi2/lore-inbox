Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVFNHQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVFNHQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFNHQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:16:32 -0400
Received: from out01.east.net ([210.56.193.7]:4582 "EHLO out01.east.net")
	by vger.kernel.org with ESMTP id S261282AbVFNHQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:16:28 -0400
Subject: 2.6 kernel series have noticeable performance regression
From: yangyi <yang.yi@bmrtech.com>
Reply-To: yang.yi@bmrtech.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: China Performance Team <china-perf@mvista.com>
Content-Type: text/plain
Organization: bmrtech
Message-Id: <1118733263.10339.1553.camel@montavista2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Jun 2005 15:14:24 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All

I did a performance regression test for all the 2.6 kernel series on two
x86 platforms in last two weeks and found that some version kernels do
have noticeable performance regression, some performance indices have
about 20 to 30 percent regression,
 even several indices have over 30 percent fall.

For example, on Toshiba tecra8000 laptop: for 4-bytes packet, network
throughput of 2.6.11 is just about 57.5 percent of 2.6.0, for pipe
bandwidth, the value of 2.6.11 is just about 68 percent of that value of
2.6.0, for mmap latency, the value of 2.6.11 is about 1.8 times as long
as 2.6.0.

On supermicro-6012-p6, for 64-bytes small packet, network throughput of
2.6.11 is about 66.72 percent of 2.6.0, for 0K-size 2 processes context
switch time, 2.6.11 is 31.8 percent bigger than 2.6.0, for pipe latency,
2.6.10 is 35.85 percent bigger than 2.6.3.

So, I think that it is very very necessary to find the problems and fix
them ASAP.

The following articles give out all the test results, the article "2.6
kernel series have noticeable performance regression, part 1" gives out
the test results on SuperMicro-6012-p6, the article "2.6 kernel series
have noticeable performance regression, part 2" gives out the test
results on Toshiba tecra8000 laptop.


