Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293599AbSCKEUw>; Sun, 10 Mar 2002 23:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293600AbSCKEUl>; Sun, 10 Mar 2002 23:20:41 -0500
Received: from [203.117.131.12] ([203.117.131.12]:21667 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S293599AbSCKEU3>; Sun, 10 Mar 2002 23:20:29 -0500
Date: Mon, 11 Mar 2002 12:20:26 +0800
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
To: Benjamin LaHaise <bcrl@redhat.com>
From: Michael Clark <michael@metaparadigm.com>
In-Reply-To: <20020310221530.A28821@redhat.com>
Message-Id: <507C85FA-34A7-11D6-AD8C-000393843900@metaparadigm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 11, 2002, at 11:15 AM, Benjamin LaHaise wrote:

> On Sun, Mar 10, 2002 at 06:30:33PM -0800, David S. Miller wrote:
>> Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
>> without NAPI, there is no reason other cards cannot go full speed as
>> well.
>>
>> NAPI is really only going to help with high packet rates not with
>> thinks like raw bandwidth tests.
>
> Well, the thing that hurts the 83820 is that its interrupt
> mitigation capabilities are rather limited.  This is where napi
> helps: by turning off the rx interrupt for the duration of packet
> processing, cpu cycles aren't wasted on excess rx irqs.
>
> As to the lack of bandwidth, it stems from far too much interrupt
> overhead and the currently braindead attempt at irq mitigation.
> Since the last time I worked on it, a number of potential techniques
> have come up that should bring it into the 100MB realm (assuming it
> doesn't get trampled on by ksoftirqd).

What about jumbo frames?  I notice this comment in the driver "disable
jumbo frames to avoid tx hangs".  I'm getting ~550Mb/sec from a single
TCP stream and ~700Mb/sec with 2 in parallel. Jumbo frames would
probably improve this quite a bit.

~mc

