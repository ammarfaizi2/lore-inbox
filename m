Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132531AbRDDXsG>; Wed, 4 Apr 2001 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132533AbRDDXr5>; Wed, 4 Apr 2001 19:47:57 -0400
Received: from friley-168-165.stures.iastate.edu ([129.186.168.165]:29354 "EHLO
	friley-168-165.stures.iastate.edu") by vger.kernel.org with ESMTP
	id <S132531AbRDDXrm>; Wed, 4 Apr 2001 19:47:42 -0400
Message-ID: <3ACBB35B.1060100@adiis.net>
Date: Wed, 04 Apr 2001 18:50:51 -0500
From: Ryan Butler <rbutler@adiis.net>
Organization: ADI Internet Solutions
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted due to
In-Reply-To: <Pine.LNX.4.21.0104050004060.21943-100000@campari.convergence.de> <3ACB94E3.2030108@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:

> 
> 
> Personally, I agree with you, but I can also understand David's
> desire to avoid wasting time chasing phantom bugs that only
> show up due to this broken hardware.  If it turns out that
> there is actually a well-defined workaround that AMD will
> tell us about, it shouldn't take too long before we have a
> real fix and the AMD-756 can be taken off of the blacklist.
> 
> My guess is that there are specific drivers for which this
> hardware bug causes problems.  You probably just aren't
> using the *right* drivers.  :-)
> 
00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB 
(rev 06) (prog-if 10 [OHCI])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
   Latency: 80 max, 16 set, cache line size 08
   Interrupt: pin D routed to IRQ 10
   Region 0: Memory at efffd000 (32-bit, non-prefetchable) [size=4K]


This is also a rev 06 chip, on a MSI K7Pro (Slot A) board.

The only item I use with it is a Creative Webcam III and I have yet to 
see this error with any kernel version in the 2.4.x series.

So I think you might be right about certain drivers exposing the 
hardware flaw.

As for not blacklisting the whole chipset, its probably the smart thing 
to do, and for those who really really want to use the driver anyhow, a 
simple diff between the usb-ohci.c files between 2.4.2 and 2.4.3 shows 
how to remove the blacklist.

Ryan Butler
ADI Internet Solutions
rbutler@adiis.net

