Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAKPW5>; Thu, 11 Jan 2001 10:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRAKPWq>; Thu, 11 Jan 2001 10:22:46 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:44295 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129790AbRAKPW1>;
	Thu, 11 Jan 2001 10:22:27 -0500
Date: Thu, 11 Jan 2001 16:22:00 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010111162200.J20535@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D9D87.8A868F6A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 11, 2001 at 10:48:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 10:48:23PM +1100, Andrew Morton wrote:
> Losing both NICs at the same time could be the elusive "APIC
> stops generating interrupts" problem.

Yup, that's what I thought... But the real question is, is this a
software/configuration problem or a hardware problem which can only be fixed by
physically changing something on the board?... As it is, as you call it,
'elusive', it is a b*tch to pinpoint the source of these problems...

> Do you get any transmit timeout messages in the logs?  If
> so, send them.

Here they are (marked with ***):

grep -B2 -A2 transmit /var/log/messages:
    Jan 10 22:24:47 behemoth kernel: usb_control/bulk_msg: timeout 
    Jan 10 22:24:50 behemoth kernel: usb_control/bulk_msg: timeout 
*** Jan 10 22:56:51 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
    Jan 10 22:57:03 behemoth last message repeated 7 times
    Jan 10 22:57:03 behemoth kernel: SysRq: Emergency Sync 
    --
    Jan 10 22:57:09 behemoth kernel: Syncing device 16:07 ... OK 
    Jan 10 22:57:09 behemoth kernel: Done. 
*** Jan 10 22:57:09 behemoth kernel: NETDEV WATCHDOG: eth0: transmit timed out 
    Jan 10 22:57:09 behemoth kernel: SysRq: Emergency Sync 
    Jan 10 22:57:09 behemoth kernel: Syncing device 03:01 ... OK 

> Does it happen with a uniprocessor build?

Not tried yet, since I wanna use both CPU's :-).

> Are you able to boot with the `noapic' LILO option?

I am, and did it a while ago. As far as I remember, it did not make it stop...
I'll try again (even though it is not a real solution, since that APIC is there
for a reason...)

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
