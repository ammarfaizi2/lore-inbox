Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRJCPRX>; Wed, 3 Oct 2001 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276359AbRJCPRN>; Wed, 3 Oct 2001 11:17:13 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:59063 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276354AbRJCPQ7>;
	Wed, 3 Oct 2001 11:16:59 -0400
Date: Wed, 3 Oct 2001 11:14:41 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031528370.6272-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110031109430.4833-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ingo Molnar wrote:

Robert has a driver extension (part of Alexey's iputils) that cna
generate in the 140Kpps (for 100Mbps) and about 900Kpps for the e1000, but
i'll take a look at Simons stuff if it is available. Marc Boucher has
something that is an in-kernel client/server  as well.

> 10.0.3.4 is running vanilla 2.4.11-pre2 UP, a 466 MHz PII box with enough
> RAM, using eepro100. The system effectively locks up - even in the full
> knowledge of what is happening, i can hardly switch consoles, let alone do
> anything like ifconfig eth0 down to fix the lockup. Until this kind of
> load is present the only option is to power-cycle the box. SysRq does not
> work.

use the netif_rx() return code and hardware flowcontrol to fix it.

> and frankly, this has been well-known for a long time - it's just since
> Simon sent me this testcode that i realized how trivial it is. Alexey told
> me about Linux routers effectively locking up if put under 100 mbit IRQ
> load more than a year ago, when i first tried to fix softirq latencies. I
> think if you are doing networking patches then you should be aware of it
> as well.
>

I am fully aware of it. We have progessed extensively since then. Look at
NAPI.

> your refusal to accept this problem as an existing and real problem is
> really puzzling me.
>

I must have miscommunicated. I am not saying there is no problem otherwise
i wouldnt be working on this to begin with. I am just against your shotgun
approach.

cheers,
jamal

