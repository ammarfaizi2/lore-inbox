Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319384AbSIFUrx>; Fri, 6 Sep 2002 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319385AbSIFUrx>; Fri, 6 Sep 2002 16:47:53 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:5128 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S319384AbSIFUrw>;
	Fri, 6 Sep 2002 16:47:52 -0400
Subject: Re: virtual ethernet adapter?
From: Shaya Potter <spotter@cs.columbia.edu>
To: Peter Svensson <petersv@psv.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209061450080.1994-100000@cheetah.psv.nu>
References: <Pine.LNX.4.44.0209061450080.1994-100000@cheetah.psv.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Sep 2002 16:49:14 -0400
Message-Id: <1031345355.8367.12.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 08:53, Peter Svensson wrote:
> On 6 Sep 2002, Shaya Potter wrote:
> 
> > from what I can tell, tap just lets a programs use it, but one needs
a
> > user space app behind it (reading and writing to it).  It doesn't
seem
> > to have the ability to live on the network like vmware's vmnet stuff
> > does, perhaps I'm wrong and was confused by the web page.
> 
> Well, you want at program to read and write ethernet frames, don't
you? To 
> What happens is that the operating system sees the data written by the
> program as coming in over a ethernet interface, a virtual one.
> 
> To connect that interface to a real one you use the bridging code. I
think 
> it is standard in the newer kernels. Otherwise you can download it
from
> http://bridge.sourceforge.net/. Create a bridge and attach both the
real 
> ethernet card and the virtual one to it and use the resulting
interface 
> br0 (or whatever you choose to call it) instead of the normal ethernet
> interface. Your program that is attached to the "tap" will now appear
as 
> another computer on the same ethernet segment to both your computer
and 
> all others attachet the the segment.

that actually sounds more promising, but does it still involves the
program attached to the tap outputting ethernet frames.  i.e. I can't
make a virtual ethernet driver with my own rules, have netfilter bind a
process to just use that adapter, and then just run the process as
normal.  or am I still understating the capabilities?

thanks,

shaya potter

