Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBHQJW>; Thu, 8 Feb 2001 11:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRBHQJD>; Thu, 8 Feb 2001 11:09:03 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:34308
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129063AbRBHQIy>; Thu, 8 Feb 2001 11:08:54 -0500
Date: Thu, 8 Feb 2001 08:08:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Adam Lackorzynski <al10@inf.tu-dresden.de>
cc: "Zink, Dan" <Dan.Zink@COMPAQ.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'mj@suse.cz'" <mj@suse.cz>
Subject: Re: [Patch] ServerWorks peer bus fix for 2.4.x
In-Reply-To: <20010208125402.A11395@inf.tu-dresden.de>
Message-ID: <Pine.LNX.4.10.10102080806540.1415-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Adam Lackorzynski wrote:

> On Thu Feb 08, 2001 at 03:06:27 -0800, Andre Hedrick wrote:
> > Have you got a hack for 2.2.18/19x ??
> 
> I do not have problems with 2.2.x Kernels here. They see all the PCI
> devices just fine.

But it will not register the device

  Bus  0, device  15, function  2:
    USB Controller: Unknown vendor OSB4 USB (rev 4).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable. Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xfe9fc000 [0xfe9fc000].
  Bus  1, device   2, function  0:
    RAID storage controller: CMD 649 (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 27.  Master Capable. Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0xefe0 [0xefe1].
      I/O at 0xefac [0xefad].
      I/O at 0xefa0 [0xefa1].
      I/O at 0xefa8 [0xefa9].
      I/O at 0xef90 [0xef91].

The interrupts are invalid.
It wants 10 and it is yeilding 27.
This is the first time it has ever done this with my code.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
