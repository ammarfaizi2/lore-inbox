Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRCOSKv>; Thu, 15 Mar 2001 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRCOSKl>; Thu, 15 Mar 2001 13:10:41 -0500
Received: from raven.toyota.com ([63.87.74.200]:27405 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131378AbRCOSKX>;
	Thu, 15 Mar 2001 13:10:23 -0500
Message-ID: <3AB10563.42FE7170@toyota.com>
Date: Thu, 15 Mar 2001 10:09:39 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mårten Wikström <Marten.Wikstrom@framfab.se>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
In-Reply-To: <E6D22E487D45D411931B00508BCF93E75C0326@storeg001.framfab.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just my .02 -

There are some scheduler patches that are not part of the
main kernel tree at this point (mostly since they have yet to
be optimized for the common case) which make quite a big
difference under heavy load - you might want to check out:

    http://lse.sourceforge.net/scheduling/

cu

Jup


Mårten Wikström wrote:

> I've performed a test on the routing capacity of a Linux 2.4.2 box versus a
> FreeBSD 4.2 box. I used two Pentium Pro 200Mhz computers with 64Mb memory,
> and two DEC 100Mbit ethernet cards. I used a Smartbits test-tool to measure
> the packet throughput and the packet size was set to 64 bytes. Linux dropped
> no packets up to about 27000 packets/s, but then it started to drop packets
> at higher rates. Worse yet, the output rate actually decreased, so at the
> input rate of 40000 packets/s almost no packets got through. The behaviour
> of FreeBSD was different, it showed a steadily increased output rate up to
> about 70000 packets/s before the output rate decreased. (Then the output
> rate was apprx. 40000 packets/s).
> I have not made any special optimizations, aside from not having any
> background processes running.
>
> So, my question is: are these figures true, or is it possible to optimize
> the kernel somehow? The only changes I have made to the kernel config was to
> disable advanced routing.
>
> Thanks,
>
> Mårten
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

