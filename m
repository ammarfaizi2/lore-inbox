Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTLPW4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTLPW4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:56:43 -0500
Received: from b1.ovh.net ([213.186.33.51]:27590 "EHLO mail8.ha.ovh.net")
	by vger.kernel.org with ESMTP id S264277AbTLPWzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:55:19 -0500
Message-ID: <1071615336.3fdf8d6840208@ssl0.ovh.net>
Date: Tue, 16 Dec 2003 23:55:36 +0100
From: Miroslaw KLABA <totoro@totoro.be>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Double Interrupt with HT
References: <20031215155843.210107b6.totoro@totoro.be> <1071603069.991.194.camel@cog.beaverton.ibm.com>
In-Reply-To: <1071603069.991.194.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 81.250.170.171
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had the problem with 2.4.22, 2.4.22-ac4, 2.4.23 and 2.4.24-pre1.
The problem is that all the kernel is working "twice the speed".
The command "while true; do date; sleep 1; done;" shows that the date is growing
2 seconds per second... :/
I found a patch for irqbalance for 2.4.23, and now I don't have the problem 
anymore with the clock.
http://www.hardrock.org/kernel/2.4.23/irqbalance-2.4.23-jb.patch

With 2.6.0-test11, I didn't have any problem, but we can't switch to 2.6.0 yet
production.
I think it is a bug with the via chipset, but I'm not able to get deeper in the
kernel code.

Thanks
Miro






Quoting john stultz <johnstul@us.ibm.com>:

> On Mon, 2003-12-15 at 06:58, Miroslaw KLABA wrote:
> > I've got a problem while using Hyper-Threading on a motherboard with Via
> P4M266A
> > chipset with 2.4.23 kernel.
> 
> Could you try to narrow down when the problem first appeared? Was it not
> seen in 2.4.23-pre3 but showed up in 2.4.23-rc1? The narrower the
> better. 
> 
> thanks
> -john
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


