Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267208AbUBSLkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 06:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUBSLkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 06:40:40 -0500
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:55684 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267208AbUBSLkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 06:40:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.6.3 {-mm1} kernbench
Date: Thu, 19 Feb 2004 22:40:21 +1100
User-Agent: KMail/1.6
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402192240.21839.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_domains is performing nicely on the SMT numa box I tested on 
previously but it seems to be hurting on non-numa, non-SMT machines. This 
showed up when sched_smt was disabled on the X440 so I tried it on the 
regular osdl non smt machines. Check the results below (8xPIII 700Mhz).

kernel: linux-2.6.3
plmid: 2631
Host: stp8-003

Average Optimum Load Run:
Elapsed Time 129.482
User Time 868.338
System Time 85.52
Percent CPU 736.4
Context Switches 28352.4
Sleeps 30214.6

Average Maximum Load Run:
Elapsed Time 130.778
User Time 865.722
System Time 101.972
Percent CPU 739.4
Context Switches 24230
Sleeps 20382.2

Average Half Load Run:
Elapsed Time 231.274
User Time 834.47
System Time 73.05
Percent CPU 391.8
Context Switches 8946.2
Sleeps 22328.8


kernel: 2.6.3-mm1
plmid: 2632
Host: stp8-003

Average Optimum Load Run:
Elapsed Time 131.468
User Time 868.3
System Time 86.272
Percent CPU 725.6
Context Switches 24486.2
Sleeps 27684.4

Average Maximum Load Run:
Elapsed Time 134.264
User Time 869.318
System Time 101.906
Percent CPU 723
Context Switches 24658.2
Sleeps 20603.2

Average Half Load Run:
Elapsed Time 273.688
User Time 831.614
System Time 69.666
Percent CPU 329.8
Context Switches 17771.4
Sleeps 21575.2


All loads are affected but the half load run particularly suffers, with many 
more context switches.

Con
