Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129754AbRBMD0Y>; Mon, 12 Feb 2001 22:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRBMD0O>; Mon, 12 Feb 2001 22:26:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:26498 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129731AbRBMDZ7>;
	Mon, 12 Feb 2001 22:25:59 -0500
Date: Tue, 13 Feb 2001 04:25:21 +0100
From: David Weinehall <tao@acc.umu.se>
To: xcp <xcp@ogel.aura.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/pci and cpuinfo
Message-ID: <20010213042521.A27301@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.31.0102121844430.7164-100000@ogel.aura.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.31.0102121844430.7164-100000@ogel.aura.li>; from xcp@ogel.aura.li on Mon, Feb 12, 2001 at 06:49:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 06:49:13PM -0800, xcp wrote:
> I have a machine here with a discrepency on the pci information
> in /proc/pci:
> us  0, device  20, function  0:
>     Ethernet controller: 3Com Unknown device (rev 48).
>       Vendor id=10b7. Device id=7646.
>       Medium devsel.  IRQ 12.  Master Capable.  Latency=32.  Min
> Gnt=10.Max Lat=10.
>       I/O at 0xe400 [0xe401].
>       Non-prefetchable 32 bit memory at 0xdf000000 [0xdf000000].
> 
> from lspci:
> 00:14.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane (rev
> 30)
> 
> clearly /proc/pci is wrong!

Exactly where? bus 0, device 20, function 0 == hex(00:14.0)
Revision 48 = hex(30)

And both says that it's an Ethernet controller from 3Com. The fact that
the PCI-ID database in v2.2.18 isn't quite as extensive as the one in
lspci isn't something that makes your system malfunction...

> kernel is 2.2.18 on a P3-450 256mb.
> 
> Also, where does Linux detect and document the L2 or L1 cache size on a
> socket7 system?  On the pentium3 its in cpuinfo as cache_size, no such
> value exists on my P120 system.

That's probably because there is no simple way to query the processor for
this information. I'll let Peter Anvin answer this one, however.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
