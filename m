Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRDJMqM>; Tue, 10 Apr 2001 08:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDJMqE>; Tue, 10 Apr 2001 08:46:04 -0400
Received: from ns.suse.de ([213.95.15.193]:6667 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131643AbRDJMp4>;
	Tue, 10 Apr 2001 08:45:56 -0400
Date: Tue, 10 Apr 2001 14:45:54 +0200
From: Andi Kleen <ak@suse.de>
To: Mark Salisbury <mbs@mc.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410144554.A16207@gruyere.muc.suse.de>
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <01040914220214.01893@pc-eng24.mc.com> <20010410075109.A9549@gruyere.muc.suse.de> <01041008110318.01893@pc-eng24.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041008110318.01893@pc-eng24.mc.com>; from mbs@mc.com on Tue, Apr 10, 2001 at 08:07:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 08:07:04AM -0400, Mark Salisbury wrote:
> which kind of U/K accaounting are you referring to?
> 
> are you referring to global changes in world time? are you referring to time
> used by a process? 

The later.

> 
> I think the reduction of clock interrupts by a factor of 10 would buy us some
> performance margin that could be traded for a slightly more complex handler.

It depends on your workload if you can trade that in. e.g. when a few hundred TCP
sockets are active a lot of timer ticks will run some timer handler. Also generally
the kernel has quite a lot of timers. There is some reduction on a idle system. That
is no doubt useful for VM/UML/VMware where you can have idle sessions hanging around, 
but otherwise it's not very interesting to optimize idle systems (except maybe for 
power saving purposes)


-Andi
