Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287320AbSACPOm>; Thu, 3 Jan 2002 10:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287321AbSACPOc>; Thu, 3 Jan 2002 10:14:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63360 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287320AbSACPOW>; Thu, 3 Jan 2002 10:14:22 -0500
Date: Thu, 3 Jan 2002 10:15:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: <200201031431.g03EVLpa021956@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.3.95.1020103100747.4554A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Horst von Brand wrote:

> "Eric S. Raymond" <esr@thyrsus.com> said:
> 
> [...]
> 
> > Yes. But *I* want Aunt Tilley to be able to download the latest kernel
> > sources and build/install them herself, without ever feeling that the task 
> > is beyond her capabilities.  
> 
> Come on, how many Aunts do you have that even know (or care) what a
> "kernel" is, let alone think of "building the latest from source"?
> 
> > Part of the reason I want this is for the capability itself; partly I want
> > it pour encourager les autres -- to demonstrate, by tackling one of the 
> > toughest cases, that much of the complexity and anti-useability of Linux
> > is an artificial and unnecessary creation of the culture that created it,
> > rather than a result of actual technical depth of the problem.
> 
> Then do your demonstration on something that is actually useful in real
> life, non? Like making using Linux + Apache + <whatever> easier to use for
> secure websites (I've recently read that MS IIS is doing _large_ inroads
> there). That could make a real difference in "World domination. Fast."
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513



"is an artificial and unnecessary creation of the culture that created
it.."

WRONG!

It's not the culture, it's the hardware.

PCI has a vendor and device ID code in addition to dynamic
addressing and dynamic resource allocation. It is, therefore,
theoretically possible to perfectly configure any system
with no user input required.

ISA has nothing. Just fixed port addressing where an attempt
is made to find out something about the hardware by writing
and reading the results. If you think you have device 'A'
at port N, but you don't, and you write something to condition
device 'A' for a response, you could, in fact, tell another
device to hit the reset switch or, worse, format your disk(s).
These problems are exacerbated because ISA devices typically
don't decode all the address bits. You could have a hard-disk
controller aliased to the same address as your new communications
widget. Basically ISA == JUNK and "modern" users continue to
use this obsolete interface bus.

Because there are certain ISA port addresses that have historically
been used for certain devices, it is possible to probe and configure
a high percentage of devices based upon software with a historical
knowledge. However, when a new device comes along, all bets are
off. For this reason, "plug-and-play" for ISA devices isn't
reliable and can't ever be.

Apple also has limited address space for devices. However, since
the apple-sauce machine peripherals were all made under license,
because the architecture was closed, this assured that there
were not any duplicate decodes. It also made probing unnecessary.
Modern apple-sauce machines have PCI so, just like modern Intel/PC
machines, no probing is necessary.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


