Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRARXxj>; Thu, 18 Jan 2001 18:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRARXxa>; Thu, 18 Jan 2001 18:53:30 -0500
Received: from gateway.sequent.com ([192.148.1.10]:25244 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S130241AbRARXxV>; Thu, 18 Jan 2001 18:53:21 -0500
Date: Thu, 18 Jan 2001 15:53:11 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: multi-queue scheduler update
Message-ID: <20010118155311.B8637@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just posted an updated version of the multi-queue scheduler
for the 2.4.0 kernel.  This version also contains support for
realtime tasks.  The patch can be found at:

http://lse.sourceforge.net/scheduling/

Here are some very preliminary numbers from sched_test_yield
(which was previously posted to this (lse-tech) list by Bill
Hartner).  Tests were run on a system with 8 700 MHz Pentium
III processors.

                           microseconds/yield
# threads      2.2.16-22           2.4        2.4-multi-queue
------------   ---------         --------     ---------------
16               18.740            4.603         1.455
32               17.702            5.134         1.456
64               23.300            5.586         1.466
128              47.273           18.812         1.480
256             105.701           71.147         1.517
512               FRC            143.500         1.661
1024              FRC            196.425         6.166
2048              FRC              FRC          23.291
4096              FRC              FRC          47.117

*FRC = failed to reach confidence level

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
15450 SW Koll Parkway
Beaverton, OR 97006-6063                     (503)578-3494
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
