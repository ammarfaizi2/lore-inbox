Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271217AbTHKFrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTHKFrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:47:40 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:12219 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S271217AbTHKFri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:47:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 anticipatory scheduler comment
Date: Mon, 11 Aug 2003 01:47:36 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110147.36942.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.63.55] at Mon, 11 Aug 2003 00:47:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I am running 2.6.0-test3 ATM, and amanda was fired off at 00:30 as 
usual.

Typically the estimate phase will be completed, and a dump of 
something begun somewhere around 27-30 minutes into the run.

I don't think the scheduler is giving amanda near enough time, gkrellm 
says the cpu is 95% nice, meaning the setiathome is still getting its 
normal time slices.  Its now 1:06 into the run, and still getting 
estimates.  Way too slow.  At 1:14, I reniced the amanda processes to 
-10, and I can see a slight hit in the seti usage.  At 1:19 into the 
run, its actually starting dumps with tar.

The system is quite responsive, whereas if I was running 2.4.22-rc2, 
some of the things amanda would do would have me looking at a blank 
line not showing what I just typed until 10 to 20 seconds after I'd 
typed it.  So that parts nice but it needs to borrow time from seti, 
already running at a nice of 20, not amanda and its sub processes 
running at 0.

Is there something I can set in /proc that would effect this?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

