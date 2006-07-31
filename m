Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWGaQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWGaQwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWGaQwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:52:38 -0400
Received: from [218.38.54.68] ([218.38.54.68]:46286 "EHLO vajra.mgame.com")
	by vger.kernel.org with ESMTP id S1030243AbWGaQwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:52:36 -0400
Date: Tue, 1 Aug 2006 01:52:35 +0900 (KST)
From: Vajra <vajra@vajra.mgame.com>
To: linux-kernel@vger.kernel.org
Subject: vm.min_free_kbytes / is it per CPU setting?
Message-ID: <Pine.LNX.4.64.0608010101170.25605@vajra.mgame.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I set vm.min_free_kbytes=65536 in /etc/sysctl.conf and rebooted.
After reboot, I transferred 4GB DVD iso images from FTP server
on local lan and monitored mem usage with vmstat.

...
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
  0  0      0 151520   4456 1854324    0    0     0 12276 13533 16275  1 17 
82  1
  1  0      0 139864   4472 1865868    0    0     0 12472 13438 16237  1 16 
83  0
  1  0      0 128080   4480 1877352    0    0     0 12160 13449 16298  1 17 
82  0
  0  0      0 127360   2668 1879640    0    0    12  8420 13380 16285  1 18 
70 11
  1  0      0 128488    832 1880932    0    0     0 12436 13397 16192  2 18 
81  0
  1  0    700 128116    840 1880700    0    0     4 12224 13490 16233  1 18 
80  0
  0  0    956 127620    856 1880836    0    0     0 12564 13436 16227  1 17 
82  0
  1  0   1212 127856    868 1880432    0    0    24 12112 13478 16306  1 17 
81  2
  1  0   1468 128104    876 1879896    0    0     0  8292 13416 16272  1 18 
81  0
  1  0   1980 128104    884 1879376    0    0     0 12480 13442 16184  1 17 
82  0
  1  0   2236 128104    892 1879248    0    0    16 12432 13399 16212  1 18 
80  0
  1  0   2400 127852    888 1879156    0    0     0 12440 13472 16244  1 17 
82  0
  1  0   2400 127728    888 1879088    0    0     0 12436 13390 16280  1 18 
81  0
  1  0   2432 127852    896 1878844    0    0    16  8336 13489 16280  0 17 
81  1
  1  0   2440 127620    900 1879240    0    0     0 12432 13464 16250  1 17 
83  0
...

It looks like the kernel tried to maintain 128KB of free mem instead of 
keeping 64KB of free mem as I expected.  Is that normal?  If it is, why?

I'm using Mandriva 2006 on a dual Xeon 2.4GHz, 2GB RAM system.
Kernel version is 2.6.12-24mdk, and I recompiled the source to include 
needed drivers and features only.

-- Vajra

