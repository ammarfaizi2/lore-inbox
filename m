Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUB1LAN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUB1LAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:00:13 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:52709 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261224AbUB1LAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:00:04 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re:  sched domains kernbench improvements
Date: Sat, 28 Feb 2004 21:59:58 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402282159.58452.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick

> So it is more a matter of tuning than anything fundamental

Geez I know how you feel... :-D


I tried it on the X440 with sched smt disabled

better than before but still slower than vanilla on half load; however better 
than vanilla on optimal and full load now! I wonder whether the worse result 
on half load is as relevant since this is 8x HT cpus?

Full details:


vanilla:
Average Half Load Run:
Elapsed Time 120.186
User Time 800.614
System Time 92.604
Percent CPU 742.4
Context Switches 10430.6
Sleeps 26554.6

Average Optimum Load Run:
Elapsed Time 81.67
User Time 1009.54
System Time 113.614
Percent CPU 1374.6
Context Switches 63728
Sleeps 41399.4

Average Maximum Load Run:
Elapsed Time 83.148
User Time 1014.54
System Time 123.806
Percent CPU 1368.4
Context Switches 45229.6
Sleeps 22077.6


-mm no SMT (sorry didnt do max load):
Average Half Load Run:
Elapsed Time 133.51
User Time 799.268
System Time 92.784
Percent CPU 669
Context Switches 19340.8
Sleeps 24427.4

Average Optimum Load Run:
Elapsed Time 81.486
User Time 1006.37
System Time 106.952
Percent CPU 1366.8
Context Switches 33939
Sleeps 32453.4


-mm less idle:
Average Half Load Run:
Elapsed Time 128.23
User Time 819.256
System Time 93.09
Percent CPU 713
Context Switches 18566.2
Sleeps 24663.8

Average Optimum Load Run:
Elapsed Time 79.844
User Time 1004.26
System Time 106.74
Percent CPU 1391.8
Context Switches 33718
Sleeps 33007.8

Average Maximum Load Run:
Elapsed Time 81.47
User Time 1008.32
System Time 119.652
Percent CPU 1384.4
Context Switches 31296.6
Sleeps 22667.6

Con
