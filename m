Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311820AbSCNVox>; Thu, 14 Mar 2002 16:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311825AbSCNVol>; Thu, 14 Mar 2002 16:44:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311820AbSCNVoa>; Thu, 14 Mar 2002 16:44:30 -0500
Date: Thu, 14 Mar 2002 16:44:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: John Heil <kerndev@sc-software.com>, linux-kernel@vger.kernel.org,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <Pine.LNX.4.33.0203141324480.9855-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1020314164142.382B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Linus Torvalds wrote:

> 
> On Thu, 14 Mar 2002, Richard B. Johnson wrote:
> > 
> > Well I can see why he's an EX-Phoenix BIOS developer. A port at 0xed
> > does not exist on any standard or known non-standard Intel/PC/AT 
> > compatible.
> 
> Note that "doesn't exist" is actually a _bonus_. It means that no 
> controller will answer to it, which causes the IO to time out, which on a 
> regular ISA bus will also take the same 1us. Which is what we want.
> 
> Real ports with real controllers can be faster - they could, for example,
> be fast motherboard PCI ports and be positively decoded and be faster than
> 1us.
> 
> 		Linus
> 

Well no, IO doesn't "time-out". The PC/AT/ISA bus is asychronous, it's
not clocked. If there's no hardware activity as a result of the write
to nowhere, it's just a no-op. The CPU isn't slowed down at all. It's
just some bits that got flung out on the bus with no feed-back at all.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

