Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKAXoe>; Wed, 1 Nov 2000 18:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbQKAXo2>; Wed, 1 Nov 2000 18:44:28 -0500
Received: from mx2.core.com ([208.40.40.41]:4044 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S129092AbQKAXoR>;
	Wed, 1 Nov 2000 18:44:17 -0500
Message-ID: <3A00B8E9.D5FD12B0@megsinet.net>
Date: Wed, 01 Nov 2000 18:44:25 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "CRADOCK, Christopher" <cradockc@oup.co.uk>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"CRADOCK, Christopher" wrote:
> 
> I have a similar hardware list and I don't observe any of these problems on
> 2.4.0-test10x. Is it possibly a hardware conflict somewhere?
> 
> What I do see occasionally is if X was ever heavy on the memory usage (say
> I've run GIMP for a couple of hours) then the text console's font set gets
> trashed until the next reboot. Console driver failing to reset something?
> 
> Chris Cradock
> 

Hi Chris

Never had the trashed fonts before.

How about a better comparison of systems?
All I mentioned were r128, ne2k, PIIX4 and SMP,  barely enough to claim similar
hardware thus these aren't real problems cause you don't see them.
I can send you gory details if your interested.

My reason for claiming these are problems, maybe not show stoppers, are:

This system is rock solid on 2.2.X.

problem 1, shouldn't fail on 2.4 if it works just fine on 2.2.  Probably a locking
issue but I'm not sure.  Any idea where to put some BKL's to see if the problem
will go away?

problem 2, happens randomly, so is it a hardware problem or a software issue?  being
that the system works fine SMP and UP then my guess is a software interaction when
UP-APIC is enabled, a race condition??

problem 3, new feature in 2.4, one would expect, hey, I've got this hdwr in my system,
let me enable this option...  wait a minute the system doesn't boot...

problem 4, ISAPNP in the kernel is new for 2.4, i was pointing out that it can be
improved to make it better able to select IRQ's that work so that the user can just
upgrade to 2.4 without having to tweak the BIOS and/or the code.  I sent a patch to
Linus but he rejected it, yes I realize it was a weak attempt but it fixed my ISAPNP
problems, and no one has proposed a better solution.  Shouldn't the
first release of 2.4.0 show that it's new capabilities are ready for prime time?


Thanks,
Martin


> 1.  kernel compiled w/o FB support.  When attempting to switch
>     back to X from VC1-6 system locks hard for SMP.  Nada thing
>     fixes this except hard reset... no Alt-SysRq-B, nothing
>     DRI not enabled.  Video card has r128 chipset.
>  
> 2.  System is a NFS root machine, after a period of heavy ntwk
>     activity, eg. "make clean" in /usr/src/linux ETH0 no longer
>     works or sometimes just ntwk activity during system boot is
>     enough to cause the ETH activity to cease.
>     The only recourse is to Alt-SysRq-B the system.
>     NIC = NE2K ISA
>  
> 3. Enabling PIIX4, kernel locks hard when printing the partition
>    tables for hdc.   hdc has no partitions.
>    I think this problem is on Ted's problem list???
>  
> 4. ISAPNP assigns an invalid/unusable IRQ to NE2K NIC card.
>    Previously reported to Linus & Ingo, they asked for an MPTABLE
>    dump, haven't heard back since providing said data.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
