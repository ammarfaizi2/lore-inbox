Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318983AbSIIW3R>; Mon, 9 Sep 2002 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318975AbSIIW2r>; Mon, 9 Sep 2002 18:28:47 -0400
Received: from ns2.nealtech.net ([64.29.20.117]:12221 "EHLO nealtech.net")
	by vger.kernel.org with ESMTP id <S318967AbSIIW10>;
	Mon, 9 Sep 2002 18:27:26 -0400
Message-Id: <200209092232.SAA05145@nealtech.net>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: do_gettimeofday vs. rdtsc in the scheduler
Date: Mon, 9 Sep 2002 18:21:57 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm writing a patch for the scheduler that allows normal processes to run 
occasionally even though real-time processes completely dominate the CPU. In 
order to do this the way I want to for a specific real-time application, I 
need to keep track of the times that the schedule(void) function gets called. 
This time is then used to calculate the time difference between when a normal 
process was run last and the current time. I was trying to avoid 
do_gettimeofday because of the overhead, but now I'm wondering if rdtsc on an 
SMP machine may mess up my readings because the TSC from two different 
processors may be read. Am I right in assuming this? Secondly, any good 
suggestions on how to proceed with my patch? 


Thanks,

Anton
