Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262555AbSJGRDq>; Mon, 7 Oct 2002 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbSJGRDq>; Mon, 7 Oct 2002 13:03:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11514 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262555AbSJGRDp>;
	Mon, 7 Oct 2002 13:03:45 -0400
Message-ID: <3DA1BF9D.30A214E1@mvista.com>
Date: Mon, 07 Oct 2002 10:08:45 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Effrem Norwood <enorwood@effrem.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: strange frequent message
References: <CFEAJJEGMGECBCJFLGDBAEAFCFAA.enorwood@effrem.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Effrem Norwood wrote:
> 
> Hi all,
> 
> I'm using a 2.4.18 kernel with QLogic 6.1 Beta 5 qlaxxxx drivers patched in
> and compiled as part of the kernel rather than as a module. Dual Xeon 2.4,
> 2.0GB ram, highmem enabled (4GB), SuperMicro MB. ACPI is disabled on the MB
> as well as in the kernel.
> 
> I keep getting these weird messages:
> 
> "Uhhuh. NMI received for unknown reason 2c. Dazed and confused, but trying
> to continue Do you have a strange power saving mode enabled?"
> 
> "Uhhuh. NMI received for unknown reason 3c. Dazed and confused, but trying
> to continue Do you have a strange power saving mode enabled?"
> 
> Any ideas why this is happening?

It comes from traps.c do_nmi() when it can not decode the
NMI reason.  If all else fails you may want to alter the
code to turn it into an Oops and see what turns up.  Check
the "die" code for how to break the locks you need to
actually do an Oops from an NMI.

-g
> 
> Please cc me on replies to this as the list volume is too great for me to
> subscribe.
> 
> My thanks,
> 
> Eff Norwood
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
