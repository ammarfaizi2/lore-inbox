Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135849AbRDTKP0>; Fri, 20 Apr 2001 06:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135851AbRDTKPR>; Fri, 20 Apr 2001 06:15:17 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:50938 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S135849AbRDTKPF>; Fri, 20 Apr 2001 06:15:05 -0400
Message-ID: <3AE00B90.ECF63D78@tac.ch>
Date: Fri, 20 Apr 2001 12:12:32 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104200227420.5165-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ion,

> I think the UP-APIC support was added primarily to support the NMI oopser
> on UP systems. I might be wrong, though.

You're right, at least from the perspective of this patch:
http://www.csd.uu.se/~mikpe/linux/upapic/upapic-2.4.1
 
> You can safely disregard the "early initialization deferred" messages.
> They are essentially harmless.

Thanks for the info. I can sleep now :)
 
> As for the 16 eth ports limit, if you want to increase it, simply edit
> drivers/net/net_init.c and change the value of MAX_ETH_CARDS. This limit
> appears to also affect modules, so my earlier suggestion of using modules
> wouldn't have helped.

Thanks a lot. And sorry I don't know the kernel sources and documentations
good enough yet.
 
> If the only thing you need from your boxes is networking-related, than
> it's probably ok. Otherwise I'd wait a bit longer before putting 2.4 on
> production servers...

It is only network related (packetfiltering and load balancing with QoS) 
and I like the improved mm. I've been testing 2.4 since its early days
and f.e. on the Intel L440GX+ boards it runs like hell, also with SMP.
Only the CPU numbering is incorrect if the kernel is SMP and you only
put in one processor. But I read somewhere that also this feature is 
normal since it seems to be impossible to give the CPUs the correct
numbers because there is no defined order of initialization.
 
> Yeah, I guess I'll submit a patch to remove the experimental bit, after
> the current code changes are accepted..

Good. Yes, I saw the patches. I might try it out back here with a 2.4.x
kernel and 4 quadboards.
 
> You shouldn't need to do that, it's just wasted memory. The ethX_dev was
> used mostly to avoid probing for ISA cards, which is completely irrelevant
> when using PCI cards. As for the 4 quadboards limit, see above -- all you
> need to change is MAX_ETH_CARDS.

Will certainly do that. And thank you again for this information.
 
Best regards,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
