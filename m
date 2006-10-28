Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWJ1R2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWJ1R2c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWJ1R2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:28:32 -0400
Received: from [82.147.215.28] ([82.147.215.28]:39808 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751177AbWJ1R2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:28:32 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] kswapd: Kernel Swapper performance
Date: Sat, 28 Oct 2006 20:31:17 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200610282031.17451.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One thing that has improved in 2.6, wrt 2.4, is swapper performance.  And the 
difference isn't small either: ~5 fold increase in swapin performance.

But swapin performance still lags swapout performance by 50%, which is a bit 
odd, considering swapin to be a read from disk, usually faster, and swapout 
to be a write to disk, usually slower.

Now, this slowdown could be explained by additional seek action, caused by 
different apps paging-in at different times with different locations on 
swap.

Yet, even a single app paging-out consecutive pages, and paging-in the same 
pages in one go, exhibits this upside-down swapout/swapin performance ratio.

Improving this ratio could possibly yield a dramatic improvement in system 
performance under memory load (think tmpfs/swsusp/...).


Thanks!

--
Al

