Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268546AbRGZRlg>; Thu, 26 Jul 2001 13:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268559AbRGZRl0>; Thu, 26 Jul 2001 13:41:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60835 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268462AbRGZRlU>; Thu, 26 Jul 2001 13:41:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paul Larson <plars@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Linux 2.4.7-ac1
Date: Thu, 26 Jul 2001 12:42:10 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072612421000.21482@plars.austin.ibm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I was running the Linux Test Project's latest testsuite against 2.4.7-ac1 and 
noticed one test failed that did not fail in 2.4.7 and 2.4.6-ac5.  The 
pth_str02 test (simple test that tries to create 1000 threads) could only 
make it up to 980 threads on my machine.  Saw this change in fork.c with 
2.4.7-ac1:

-       max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 2;
+       max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 16;

Any reason why this was done?  I think the max I was ever able to hit before 
was somewhere around 1018 or so, so it's not that big of a drop.  I was just 
wondering why it was being further limited since I didn't see anything in the 
changelog about it.

Thanks,
Paul Larson
