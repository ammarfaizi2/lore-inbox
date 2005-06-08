Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVFHLf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVFHLf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVFHLf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:35:27 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:2454 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262180AbVFHLfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:35:17 -0400
Date: Wed, 08 Jun 2005 07:35:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
In-reply-to: <20050608074847.GB13452@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Message-id: <200506080735.15530.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050607194119.GA11185@elte.hu> <20050608074254.GA13452@elte.hu>
 <20050608074847.GB13452@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 03:48, Ingo Molnar wrote:
>* Ingo Molnar <mingo@elte.hu> wrote:
>> * Ingo Molnar <mingo@elte.hu> wrote:
>> > > There is a local_irq_enable missing someplace in UP ..
>> > >
>> > > BUG: scheduling with irqs disabled: khelper/0x00000000/5
>> > > caller is __down_mutex+0x276/0x440
>> > >  [<c03a88d6>] __down_mutex+0x276/0x440 (4)
>> >
>> > .config please.
>>
>> ok, managed to reproduce.
>
>ok, fixed it and uploaded the -47-30 patch with the fix.
>
> Ingo

I just built this one, with RT but without the statistical stuff 
enabled.  While rc6 works fine with tvtime-0.99, this gives a no 
video blue screen, audio ok.

Its also found a phantom usb-serial-audio device and fouled up kmix 
with two devices to control.  This causes a slash thru the icon for 
kmix on the toolbar.  The lsusb -v output is many pages in length for 
this mis-identified device as I believe thats the vendor:product for 
a labtec webcam that is plugged in.  100% el-cheapo model.

config, dmesg saved if you'd like to see them.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
