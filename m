Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSFQKCA>; Mon, 17 Jun 2002 06:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSFQKB7>; Mon, 17 Jun 2002 06:01:59 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:18828 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316878AbSFQKB7>; Mon, 17 Jun 2002 06:01:59 -0400
Date: Mon, 17 Jun 2002 11:34:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@us.ibm.com>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <Pine.LNX.4.44.0206171050050.9574-100000@e2>
Message-ID: <Pine.LNX.4.44.0206171101370.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Martin Bligh added to CC>

On Mon, 17 Jun 2002, Ingo Molnar wrote:

> irqbalance uses the set_ioapic_affinity() method to set affinity. The
> clustered APIC code is broken if it doesnt handle this properly. (i dont
> have such hardware so i cant tell, but it indeed doesnt appear to handle
> this case properly.) By wrapping around at node boundary the irqbalance
> code will work just fine.

I agree, Also we have to be careful about the usage of cpu_online_map in 
balance_irq, there might need to be a bit of reworking of some of the 
other parts to get this working e.g. being able to determine which node a 
specific IOAPIC register is on (perhaps there might be 1 or 2 IOAPICs / 
node) etc etc. Martin?

> i agree that this could be a problem, but set_ioapic_affinity() can be
> made dependent on the actual NUMA setup that is used. This is absolutely
> needed anyway for a proper /proc/irq/*/smp_affinity feature.

Agreed.

Thanks,
	Zwane
-- 
http://function.linuxpower.ca
		


