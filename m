Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVCDRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVCDRFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVCDRAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:00:54 -0500
Received: from relay2.hrnoc.net ([216.120.237.254]:11535 "EHLO
	relay2.hrnoc.net") by vger.kernel.org with ESMTP id S262918AbVCDQ6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:58:06 -0500
X-Qmail-Scanner-Mail-From: mike@waychison.com via smtp-1.hrnoc.net
X-Qmail-Scanner: 1.20st (Clear:RC:1(216.120.255.86):. Processed in 0.024484 secs)
Message-ID: <38586.66.11.176.22.1109955484.squirrel@webmail1.hrnoc.net>
In-Reply-To: <20050304110556.GC3992@stusta.de>
References: <422817C3.2010307@waychison.com>
    <20050304110556.GC3992@stusta.de>
Date: Fri, 4 Mar 2005 11:58:04 -0500 (EST)
Subject: Re: [2.6 patch] unexport complete_all
From: mike@waychison.com
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Mike Waychison" <mike@waychison.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-HR-Scan-Signature: 45d949c4412ebfc294d2c3c472b60e3f
X-HR-SA-Score: ()
X-HR-Status: HR_AVScanned-(mike@waychison.com/216.120.225.37)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 04, 2005 at 03:09:39AM -0500, Mike Waychison wrote:
>> > I didn't find any possible modular usage in the kernel.
>> >
>> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>> >
>> > --- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old	2005-03-04
>> 01:04:28.000000000 +0100
>> > +++ linux-2.6.11-rc5-mm1-full/kernel/sched.c	2005-03-04
>> 01:04:34.000000000 +0100
>> > @@ -3053,7 +3053,6 @@
>> >  			 0, 0, NULL);
>> >  	spin_unlock_irqrestore(&x->wait.lock, flags);
>> >  }
>> > -EXPORT_SYMBOL(complete_all);
>> >
>> >  void fastcall __sched wait_for_completion(struct completion *x)
>> >  {
>> > -
>>
>> This is a valid piece of API that is exported for future use.
>>...
>
> You exported this function nearly one year ago with the only comment
> "Export complete_all for module use.".
>
> Why did you add the export last year instead of simply adding it when it
> will be required?
>

Because it makes no sense to export only part of an API-set.  A good
interface should be as consistent as possible; selectively choosing what
is available for modular use fails this requirement.

The original patch was sent as I believed the lack of an exported
complete_all was purely an oversight.

Mike Waychison

