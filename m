Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVLRPm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVLRPm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLRPm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:42:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15077 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965135AbVLRPm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:42:57 -0500
Date: Sun, 18 Dec 2005 16:42:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dianogsing a hard lockup
In-Reply-To: <1134844883.11227.11.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0512181638340.17487@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0512171655390.2227@yvahk01.tjqt.qr>
 <1134844883.11227.11.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

>> some time after I load drivers (any, rt2500 or via ndiswrap) for a 
>> rt2500-based wlan card, the box locks up hard. Sysrq does not work, so I 
>> suppose it is during irq-disabled context. How could I find out where this 
>> happens?
>
>First, stick to rt2500 as you won't get help with binary only drivers
>here.
>Check the driver code & make sure it can't get stuck looping in the
>interrupt handler due to an unhandled IRQ.  Add printks.

It happens with both, and that's why I think this is not a problem
with the rt2500 driver(s), but somewhere else in the kernel. But I do
not know where, because it is a lot bigger than the rt code base.

>Try to reproduce the problem from the console, you're more likely to get
>a usable Oops.
>
I did, it just locks. No reaction to Sysrq+T/+P, which is the "hard"
in "hard lockup".



Jan Engelhardt
-- 
