Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVECO1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVECO1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVECO0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:26:46 -0400
Received: from fisica.ufpr.br ([200.17.209.129]:63718 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S261701AbVECOZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:25:09 -0400
Message-Id: <17015.35256.12650.37887@fisica.ufpr.br>
Date: Tue, 3 May 2005 11:24:56 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: problem with nice values and cpu consumption in 2.6.11-5
X-Mailer: VM 7.19 under Emacs 21.4.1
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at this cpu usage in a two-processor machine:

  893 user1   39  19  7212 5892  492 R 99.7  1.1   3694:29 mi41
 1118 user2   25   0  155m  61m  624 R 50.0 12.3 857:54.18 b170-se.x
 1186 user3   25   0  155m  62m  640 R 50.2 12.3 103:25.22 b170-se.x

The job with nice 19 seems to be using 100% of cpu time while the
other two nice 0 jobs share a single processor with 50% only. This is
persistent, not a transient. I did a kill -STOP to the nice 19 job and
a kill -CONT, and for a while it decreased the cpu usage but later
returned to the above.

This is with kernel 2.6.11-5 and top 3.2.5. What's the reason for this
(apparent??) mis-behavior and how can I correct it? This is important
because the machine is used for number-crunching and users get really
upset when they don't get the expected share of cpu time...
