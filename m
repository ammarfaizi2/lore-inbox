Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWCYPCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCYPCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 10:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCYPCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 10:02:46 -0500
Received: from 4-16-ftth.onsnet.nu ([84.35.16.4]:17 "EHLO beacon.dhs.org")
	by vger.kernel.org with ESMTP id S1751422AbWCYPCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 10:02:46 -0500
Date: Sat, 25 Mar 2006 16:02:40 +0100
From: Jonathan Black <vampjon@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: john stultz <johnstul@us.ibm.com>
Subject: uptime increases during suspend
Message-ID: <20060325150238.GA9023@beacon.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to enquire about the following behaviour:

$ uptime && sudo hibernate && uptime
 14:18:51 up 1 day, 4:12,  2 users,  load average: 0.58, 3.30, 2.42
 14:23:46 up 1 day, 4:17,  2 users,  load average: 20.34, 7.74, 3.91

I.e. the system was suspended to disk for 5 minutes, but the value
reported by 'uptime' has increased by as much, as if it had actually
continued running during that time.

I'm using Linux 2.6.16 with the latest version of the Suspend 2 patch
(2.2.1), but Nigel its maintainer says that this isn't actually related
to his suspend code, essentially the same would happen using the swsusp
code currently in the kernel, and therefore we need to ask the kernel
time code people about this issue.

I've been using suspend2 for a while now, and until some point in the
past it used to be the case that uptime would stand still during
hibernation, i.e. only counting the time during which the system was
actually up and running. This seems like more meaningful and desirable
behaviour to me.

The way it is now, one can essentially "cheat": suspend a machine, put
it in the cupboard for a couple of weeks, resume it and claim a
respectable uptime, because the uptime value only reflects how long ago
the system was first booted up, with no regard to how much of that time
it has actually been running.

Would it be possible to get the old behaviour back?

Greetings,
-- 
jonathaN
