Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVCDRMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVCDRMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbVCDRMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:12:17 -0500
Received: from relay2.hrnoc.net ([216.120.237.254]:11012 "EHLO
	relay2.hrnoc.net") by vger.kernel.org with ESMTP id S262918AbVCDRIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:08:34 -0500
X-Qmail-Scanner-Mail-From: mike@waychison.com via smtp-1.hrnoc.net
X-Qmail-Scanner: 1.20st (Clear:RC:1(216.120.255.86):. Processed in 0.024822 secs)
Message-ID: <38620.66.11.176.22.1109956113.squirrel@webmail1.hrnoc.net>
In-Reply-To: <20050304110750.GD3992@stusta.de>
References: <422817C3.2010307@waychison.com>
    <58cb370e0503040240314120ea@mail.gmail.com>
    <20050304110750.GD3992@stusta.de>
Date: Fri, 4 Mar 2005 12:08:33 -0500 (EST)
Subject: Re: [2.6 patch] unexport complete_all
From: mike@waychison.com
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       "Mike Waychison" <mike@waychison.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-HR-Scan-Signature: 4b54e2806c38bf68f13c98cfb1f4b6b4
X-HR-SA-Score: ()
X-HR-Status: HR_AVScanned-(mike@waychison.com/216.120.225.37)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 04, 2005 at 11:40:08AM +0100, Bartlomiej Zolnierkiewicz wrote:
>> On Fri, 04 Mar 2005 03:09:39 -0500, Mike Waychison <mike@waychison.com>
>> wrote:
>> > > I didn't find any possible modular usage in the kernel.
>> > >
>> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>> > >
>> > > --- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old      2005-03-04
>> 01:04:28.000000000 +0100
>> > > +++ linux-2.6.11-rc5-mm1-full/kernel/sched.c  2005-03-04
>> 01:04:34.000000000 +0100
>> > > @@ -3053,7 +3053,6 @@
>> > >                        0, 0, NULL);
>> > >       spin_unlock_irqrestore(&x->wait.lock, flags);
>> > >  }
>> > > -EXPORT_SYMBOL(complete_all);
>> > >
>> > >  void fastcall __sched wait_for_completion(struct completion *x)
>> > >  {
>> > > -
>> >
>> > This is a valid piece of API that is exported for future use.
>>
>> Let me guess: autofsng?
>>...
>
> I grepped through autofsng-0.4 but didn't find any usage.

Did you just blindly grep the userspace tarball?

There is no kernel code in there.  It's all in linux-2.6.*-autofsng-*.patch.

Mike Waychison

