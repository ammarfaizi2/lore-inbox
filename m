Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311700AbSCNRwF>; Thu, 14 Mar 2002 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311699AbSCNRvx>; Thu, 14 Mar 2002 12:51:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48773 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311698AbSCNRvh>; Thu, 14 Mar 2002 12:51:37 -0500
Date: Thu, 14 Mar 2002 12:54:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.4.33.0203141802330.1477-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.3.95.1020314124234.6420A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Martin Wilck wrote:

> 
> Hello,
> 
> the BIOS on our machines (Phoenix) uses IO-port 0x80 for storing
> POST codes, not only during sytem startup, but also for messages
> generated during SMM (system management mode) operation.
> I have been told other BIOSs do the same.
> 
> Unfortunately we can't read this information because Linux uses
> port 80 as "dummy" port for delay operations. (outb_p and friends,
> actually there seem to be a more hard-coded references to port
> 0x80 in the code).
> 
> It seems this problem was always there, just nobody took notice of it yet
> (at least in our company). Sometimes people wondered about the weird POST
> codes displayed in the LCD panel, but who cares once the machine is up...
> 
> Would it be too outrageous to ask that this port number be changed, or
> made configurable?
> 
> Martin

This is a 'N' year-old question. Do you know of a port that is
guaranteed to exist on the Intel/PC/AT class machine? If so, submit
a patch.  I proposed using 0x19h (DMA scratch register) several
years ago, but it was shot down for some reason. Then I proposed
0x42 (PIT Misc register), that too was declared off-limits. So
I suggested that the outb to 0x80 be changed to an inp, saving 
%eax on the stack first. That too was shot down. So, you try
something... and good luck.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

