Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGDVUa>; Thu, 4 Jul 2002 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSGDVU3>; Thu, 4 Jul 2002 17:20:29 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:53896 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S314080AbSGDVU2>;
	Thu, 4 Jul 2002 17:20:28 -0400
Message-ID: <3D24BC95.3030006@candelatech.com>
Date: Thu, 04 Jul 2002 14:22:29 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to make a kernel thread sleep for a short amount of time?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am re-working the net/core/pktgen code to be a kernel thread.

It is basically working, but I am having trouble making the thread
efficiently sleep for durations in the milisecond and micro-second range.

I have looked at the udelay and mdelay methods, but they busy
wait.

I do not need absolute real-time precision, so if I ask the thread
to sleep for 100 micro-seconds, it is not a big deal if it does
not wake up for 5000us.  On average, it should be very close to 100us.

I believe the answer may be to use some sort of timer and have my
thread sleep on this timer, but I cannot find any examples or
documentation on how to do this on the web.

If anyone can point me to some example code or documentation, I
would appreciate it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


