Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVJUQQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVJUQQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVJUQQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:16:16 -0400
Received: from 10.ctyme.com ([69.50.231.10]:41108 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S965016AbVJUQQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:16:15 -0400
Message-ID: <4359144F.8090504@perkel.com>
Date: Fri, 21 Oct 2005 09:16:15 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Lazarenko <vlad@lazarenko.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sata_nv + SMP = broken?
References: <4358C417.9000608@lazarenko.net>
In-Reply-To: <4358C417.9000608@lazarenko.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Vladimir Lazarenko wrote:

> Hello,
>
> Yesterday I've tried launching various kernels on Ahtlon64 Dual-core 
> X2 3800+ with MSI Neo4 Platinum SLI motherboard.
>
> The results were a total catastrophica failure. As soon as I enable 
> SMP in the kernel, the sata driver would randomly hang after a bit of 
> disk activity.
>
> Whenever apic is enabled, the system won't even be able to boot up 
> completely, and will hang VERY soon. Whenever I disable apic, the 
> system is able to bootup, but when the software mirror that I use will 
> try to resync for 2-3-10 mins, it will throw up a message and freeze 
> again.
>
> Whenever I disable apic AND lapic, the system is able to bootup AND 
> work, however after same 5-10 minutes it start spitting messages, 
> which are somewhat different thou and don't hang the system completely 
> but render it rather unusable anyway.
>
> As soon as I disable SMP - everything works like a charm.
>

For what it's worth I too have seen this same problem. It happens when I 
use the stock Fedora kernels but not my custom compiled kernel. I'm not 
sure what I compiled differently but at the time I thought that 
something in the new kernel fixed it.

I too am running an Athlon X2 using sata_nv. I have an ASUS motherboard. 
But what I noticed was that the problem went away if I used 2 gigs of 
ram instead of 4 gigs. When you use the whole 4 gigs there is some 
memory mapping going on and I thought perhaps the problem was related to 
the sata_nv not liking the memory mapped over the 4gig barrier. I did 
not try disabling SMP.

