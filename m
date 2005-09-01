Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVIAVcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVIAVcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVIAVcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:32:11 -0400
Received: from mail.microway.com ([64.80.227.22]:53393 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S1030393AbVIAVcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:32:10 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: linux-kernel@vger.kernel.org
Subject: latency doubled on tg3 device from 2.6.11 to 2.6.12
Date: Thu, 1 Sep 2005 17:30:51 -0400
User-Agent: KMail/1.7.2
Cc: eliot@microway.com
Message-Id: <200509011730.51990.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 We have been testing latency and bandwidth using our proprietary MPI link 
checker tool (http://www.microway.com/mpilinkchecker.html) and have found 
that the latency increased from ~25ms to ~45ms going from 2.6.11 to 2.6.12.  
2.6.13 has the same result.  We also tried the latest bcm5700 from broadcom 
(8.2.18) and got the same ~45ms latencies.  This was tried on several 
different opteron and em64t motherboards.

 We see 20-25ms latencies with the e1000 driver (with some module options) on 
all 3 kernel versions.  For those interested, the e1000 options used are:

 InterruptThrottleRate=0 RxIntDelay=0 TxIntDelay=0 RxAbsIntDelay=0 
TxAbsIntDelay=0

 Digging through source, it seems that a new locking mechanism for tg3 was put 
in place in 2.6.12.  Is this the likely cause?  What can we do to restore our 
lower latency?


-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517
