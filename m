Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTDNVT6 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTDNVT6 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:19:58 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:47785 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263798AbTDNVTz (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:19:55 -0400
Date: Mon, 14 Apr 2003 17:27:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304141731_MC3-1-3462-2342@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:


>>
>>but seek time is some combination of headswitch time, rotational 
>>latency, and actual head motion.  the first three are basically
>>not accessible in any practical way.  the latter is easy, and the 
>>
> Yep which is one reason why I don't think being fancy will pay
> off (the other reason being that even if you did know the parameters
> I don't think they would help a lot).


 The graphs in the "skippy" disk benchmark paper are
interesting -- some disks show bizarre peaks and dips in their
times across increasing sector distances. (The lesson here might
be to test your disks and avoid the bad actors rather than try
to compensate for their behavior, though.)


> There is (in AS) no cost function further than comparing distance
> from the head. Closest forward seek wins.


 The RAID1 code has its own scheduler that does similar things.  Why
aren't they being integrated? (See raid1.c:read_balance())

--
 Chuck
