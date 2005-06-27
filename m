Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVF0V0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVF0V0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0VSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:18:30 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:6120 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261818AbVF0VIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:08:54 -0400
Date: Mon, 27 Jun 2005 17:08:37 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <Pine.LNX.4.63.0506271211510.8605@ghostwheel.llnl.gov>
To: linux-kernel@vger.kernel.org
Message-id: <200506271708.37314.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
 <Pine.LNX.4.63.0506271211510.8605@ghostwheel.llnl.gov>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 15:42, Chuck Harding wrote:
>On Mon, 27 Jun 2005, Chuck Harding wrote:
>> What can be causing the following message to appear in dmesg and
>> how can I fix it?
>>
>> BUG: scheduling with irqs disabled: kapmd/0x00000000/46
>> caller is schedule_timeout+0x51/0x9e
>> [<c02b3bc9>] schedule+0x96/0xf6 (8)
>> [<c02b43f7>] schedule_timeout+0x51/0x9e (28)
>> [<c01222ed>] process_timeout+0x0/0x5 (32)
>> [<c0112063>] apm_mainloop+0x7a/0x96 (24)
>> [<c0115e45>] default_wake_function+0x0/0x16 (12)
>> [<c0115e45>] default_wake_function+0x0/0x16 (32)
>> [<c0111485>] apm_driver_version+0x1c/0x38 (16)
>> [<c01126f7>] apm+0x0/0x289 (8)
>> [<c01127a6>] apm+0xaf/0x289 (8)
>> [<c010133c>] kernel_thread_helper+0x0/0xb (20)
>> [<c0101341>] kernel_thread_helper+0x5/0xb (4)
>>
>> This was also present in earlier final-V0.7.50 version I've tried
>> (since -00) I don't get hangs but that doesn't look like it should
>> be happening. Thanks.
>
>another symptom (don't know if it's actually related) is that if I
>try to switch to a virtual consol (ctl-alt-chift-F[1..6] the screen
>won't change out of graphics mode - it goes black like it's trying
>to switch but comes back with the graphical screen which isn't
> responsive and hitting alt-F7 restores it to operation. I just
> rebooted to a kernel that doesn't have the RT-preempt patch but
> uses the same .config and everything for switching between X and
> virtual terminals works just fine.

Its working ok here, but not with those keystrokes. I just did it 
several times.  Its ctl+alt+Fn here, and always has been.

What I did see on VT#1, where the boinc stuff was being spit out 
before I logged in and did a startx, is that I have less then a 
screenfull of history available, and unlike previous kernels, I'm 
getting a very verbose running trail, almost like an strace output, 
of all the kde/kmail activities going on being output to VT#1.  VT#2 
seems normal and I was able to log into it just fine before hitting 
ctl+alt+F7 to come back to X.  Weird to say the least.

But this brings up the question re how do I enlarge the scrollback 
memory of an init-run-level=3 VT?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
