Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSIFMtW>; Fri, 6 Sep 2002 08:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSIFMtW>; Fri, 6 Sep 2002 08:49:22 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:40344 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S318552AbSIFMtW>;
	Fri, 6 Sep 2002 08:49:22 -0400
Date: Fri, 6 Sep 2002 14:53:58 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Shaya Potter <spotter@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: virtual ethernet adapter?
In-Reply-To: <1031315698.28301.12.camel@zaphod>
Message-ID: <Pine.LNX.4.44.0209061450080.1994-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Sep 2002, Shaya Potter wrote:

> from what I can tell, tap just lets a programs use it, but one needs a
> user space app behind it (reading and writing to it).  It doesn't seem
> to have the ability to live on the network like vmware's vmnet stuff
> does, perhaps I'm wrong and was confused by the web page.

Well, you want at program to read and write ethernet frames, don't you? To 
What happens is that the operating system sees the data written by the 
program as coming in over a ethernet interface, a virtual one.

To connect that interface to a real one you use the bridging code. I think 
it is standard in the newer kernels. Otherwise you can download it from
http://bridge.sourceforge.net/. Create a bridge and attach both the real 
ethernet card and the virtual one to it and use the resulting interface 
br0 (or whatever you choose to call it) instead of the normal ethernet 
interface. Your program that is attached to the "tap" will now appear as 
another computer on the same ethernet segment to both your computer and 
all others attachet the the segment.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


