Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVFGQ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVFGQ00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVFGQ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:26:26 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:36258 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S261930AbVFGQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:26:11 -0400
From: "Dan A. Dickey" <dan.dickey@savvis.net>
Reply-To: dan.dickey@savvis.net
Organization: WAM!NET a Division of SAVVIS, Inc.
To: linux-kernel@vger.kernel.org
Subject: System state too high for too long...
Date: Tue, 7 Jun 2005 11:25:41 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506071125.41543.dan.dickey@savvis.net>
X-OriginalArrivalTime: 07 Jun 2005 16:25:48.0297 (UTC) FILETIME=[901F1F90:01C56B7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem has now been persistent enough in the last few kernels
I've run that I've subscribed (once again) to the linux-kernel list
and would like to report it.
I'm using gentoo-sources-2.6.11-r9.

When the system is compiling something, the state typically
stays at about 85-95% system time.  This just really does not
seem right for my workload, and additionally only appeared
a few releases ago (sorry, I didn't bother to track it - I thought
it might go away in a release or two; but it has not).

Here is a little output of 'vmstat 5' when this is happening:
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
 1  0  12752  61548  57252 211092    0    0     2    50 1083   810 11 
89  0  0
 1  0  12752  57572  57320 211160    0    0     0    63 1089   683  9 
91  0  0
 1  0  12752  63288  57328 211220    0    0     8    39 1084   765 11 
89  0  0
 1  0  12752  60648  57348 211200    0    0     0    56 1086   647  6 
94  0  0
 1  0  12752  54972  57348 211200    0    0     0     3 1079   659  8 
92  0  0
 1  0  12752  62284  57348 211268    0    0     4    53 1087   807 17 
83  0  0
 1  0  12752  59400  57356 211328    0    0     0    34 1222  1919 17 
83  0  0

Can someone help me to debug this further?  Thanks.
	-Dan

-- 
Dan A. Dickey
dan.dickey@savvis.net

SAVVIS
Transforming Information Technology
