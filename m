Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbTBECws>; Tue, 4 Feb 2003 21:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbTBECws>; Tue, 4 Feb 2003 21:52:48 -0500
Received: from dewberry.cc.columbia.edu ([128.59.59.68]:1164 "EHLO
	dewberry.cc.columbia.edu") by vger.kernel.org with ESMTP
	id <S267755AbTBECwK>; Tue, 4 Feb 2003 21:52:10 -0500
Message-ID: <015201c2ccc2$e10729e0$bcf627a0@zhengthinkpad>
From: "Haoqiang Zheng" <hzheng@cs.columbia.edu>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux hangs with printk on schedule()
Date: Tue, 4 Feb 2003 22:01:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> oops_in_progress++;
> printk(...);
> oops_in_progress--;

Thanks Robert and Andi for your help.
But the trick (avoid waking up klog by setting oops_in_progress) doesn't
seem to work for me.

I did notice the code:
*********************************************
 if (must_wake_klogd && !oops_in_progress)
  wake_up_interruptible(&log_wait);
*****************************************
But it simply still doesn't work. :-(

I am working on implementing a new SMP scheduler. It's an OS research
project. Without "printk" in the scheduler, it's really very hard to do the
debugging. I don't know how other guys do in this case. Are you guys better
equipped than me? I mean is debugging with gdb running on another machine
(connected via serial port) a common technique? I am not sure whether it's
necessary to set up an environment like that.

Haoqiang

