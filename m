Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTJ1HwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 02:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTJ1HwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 02:52:12 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:31251 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263870AbTJ1HwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 02:52:11 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>,
       Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
Date: Tue, 28 Oct 2003 15:48:14 +0800
User-Agent: KMail/1.5.2
Cc: cliff white <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200310261201.14719.mhf@linuxmail.org> <1067311879.1512.7.camel@laptop-linux> <3F9DE858.7020109@cyberone.com.au>
In-Reply-To: <3F9DE858.7020109@cyberone.com.au>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310281548.14510.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 October 2003 11:54, Nick Piggin wrote:
> 
> Nigel Cunningham wrote:
> 
> >As you rightly guessed, I was forgetting there are now 1000 jiffies per
> >second.
> >
> >With your patch applied, I can achieve something close to 2.4
> >performance, but only if I set the limit on the number of pages to
> >submit at one time quite high. If I set it to 3000, I can get 20107 4K
> >pages written in 5267 jiffies (14MB/s) and can read them back at resume
> >time (so cache is not a factor) in 4620 jiffies (16MB/s). In 2.4, I
> >normally set the limit on async commits to 100, and achieve the same
> >performance. 100 here makes it very jerky and much slower.
> >
> >Could there be some timeout value on BIOs that I might be able to
> >tweak/disable during suspend?
> >
> 
> Try setting /sys/block/xxx/queue/iosched/antic_expire to 0 on your
> device under IO and see how it goes. That shouldn't be causing the
> problem though, especially as you are mostly writing I think?
> 
> Otherwise might possibly be the queue plugging stuff, or maybe a
> regression in the disk driver.
> 

Haven't done much of 2.6 swsusp testing due to the little diversion
with the scheduler, however I did notice one of those dreaded DMA 
timeouts with the SIS chipset again.



Regards
Michael

