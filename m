Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbRFUAtd>; Wed, 20 Jun 2001 20:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264205AbRFUAtX>; Wed, 20 Jun 2001 20:49:23 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:22470 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S264173AbRFUAtP>; Wed, 20 Jun 2001 20:49:15 -0400
Message-ID: <3B3144E2.52E098FF@idcomm.com>
Date: Wed, 20 Jun 2001 18:50:42 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Threads FAQ entry incomplete
In-Reply-To: <20010620104800.D1174@w-mikek2.des.beaverton.ibm.com>
	 <lx66drf04u.fsf@pixie.isr.ist.utl.pt> <20010620134221.C12357@qcc.sk.ca> <a05100306b756d7a9fdac@[130.161.115.44]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.D. Bakker" wrote:
> 
> At 13:42 -0600 20-06-2001, Charles Cazabon wrote:
> >Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
> >  > BTW, I have a question: Can the availability of dual-CPU boards for intel
> >>  and amd processors, rather then tri- or quadra-CPU boards, be explained with
> >>  the fact that the performance degrades significantly for three or more CPUs?
> >>  Or is there a technological and/or comercial reason behind?
> >
> >Commercial reasons.  Cost per motherboard/chipset goes way up as the number of
> >CPUs supported goes up.  For each CPU that a chipset supports, it has to add a
> >lot of pins/lands, and chipsets are already typically land-limited.
> 
> That's not quite accurate. Most modern SMP-able processors have a
> common bus, where going from 1->2 CPUs adds just a handful of extra
> nets (usually bus request, bus grant and some IRQs). The actual
> issues are threefold.

Some SMP chipset/cpu combos allow direct cache-to-cache update when a
dirty cache line is found through snooping, while the lower performance
ones don't. Wouldn't any kind of cache-to-cache direct update that
bypasses the main bus also add physical complexity (extra traces)? And
wouldn't that become more important as the number of cpu's goes up?

> 
> First, most commodity chipsets simply support no more than two CPUs
> at best; most CPUs don't support having more (or any) siblings.
> Adding more is cheap on the ASIC level, but nobody bothers because
> there is no demand.
> 
> Second, adding more CPUs on a shared bus decreases the bus bandwidth
> that is available per CPU. This is comparable with having Ethernet
> hubs vs switches. The really expensive multi-CPU boards have crossbar
> switches between CPUs, memory and PCI. Future stuff like RapidIO may
> mitigate this.
> 
> Third, the more CPUs a bus holds, the higher the capacitance on the
> bus lines. Higher capacitance means lower maximum bus speed, which
> aggravates point two.
> 
> >Motherboard trace complexity (and therefore number of layers) goes up.  Add to
> >that that the potential market goes down as CPUs goes up.
> 
> True enough.
> 
> Regards,
> 
> JDB
> [working on a SMP PowerPC design]
> --
> LART. 250 MIPS under one Watt. Free hardware design files.
> http://www.lart.tudelft.nl/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
