Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVKORYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVKORYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKORYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:24:45 -0500
Received: from esc14.midphase.com ([66.225.203.133]:45187 "EHLO
	esc14.midphase.com") by vger.kernel.org with ESMTP id S1751452AbVKORYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:24:44 -0500
Message-ID: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
Date: Tue, 15 Nov 2005 10:24:25 -0700
From: evan@coolrunningconcepts.com
To: linux-kernel@vger.kernel.org
Subject: Timer idea
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esc14.midphase.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [47 12]
X-AntiAbuse: Sender Address Domain - coolrunningconcepts.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking about benchmarking, profiling, and various other applications
that might need frequent access to the current time.  Polling timers or
frequent timer signal delivery both seem like there would be a lot of overhead.
 I was thinking it would be nice if you could just read the time information
without making an OS call.

I figure the kernel keeps accurate records of current time information and the
values of various timers.  I then had the idea that one could have a /dev or
maybe a /proc entry that would allow you to mmap() the kernel records (read
only) and then you could read this information right from the kernel without
any overhead.

Comments?  Please CC me on replies.
