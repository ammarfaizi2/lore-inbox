Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288059AbSAHOOr>; Tue, 8 Jan 2002 09:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSAHOO1>; Tue, 8 Jan 2002 09:14:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288060AbSAHOOX>; Tue, 8 Jan 2002 09:14:23 -0500
Date: Tue, 8 Jan 2002 09:14:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Anthony DeRobertis <asd@suespammers.org>
cc: jtv <jtv@xs4all.nl>, Jacques Gelinas <jack@solucorp.qc.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
In-Reply-To: <E16NwsH-0005Ud-00@asd.ppp0.com>
Message-ID: <Pine.LNX.3.95.1020108090853.226A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Anthony DeRobertis wrote:

> jtv writes: 
> 
> > On Tue, Jan 08, 2002 at 02:17:14AM -0500, Anthony DeRobertis wrote:
> >> 
> >> A nice thing about two stacks is that it can be a completely 
> >> userspace thing. No need to involve the kernel at all; just gcc 
> >> and friends.
> > 
> > Doesn't it have ABI implications as well?
> 
> On every architecture I'm familiar with. But that's a userland issue. I 
> don't believe the kernel cares how userland uses its stacks. 
> 
> Change gcc. Recompile world. All should work, assuming your gcc changes are 
> bug-free, no one made assumptions about stack layout, no one wrote assembly 
> code, etc. [In other words, after 4 months of debugging you might get X 
> running again...] 
> 
> > 
> > If so, why not go all the way and have stacks grow upwards?  :-)
> 
> Some architectures have hardware assistance for downward growing stacks. One 
> example is 68K. I think x86 does too. OTOH, I don't think PPC does, though I 
> haven't read the Green Book recently. 
> 
> Actually, if I were to be implementing split-stack, I'd probably have one 
> grow upward. Probably the data stack, because some architectures (68K, at 
> least) force the address stack to grow downwards. 
> 
> Put an unmapped page between the two stacks, and all should be fine. 

At least with Intel ix8*, even though one can create a discriptor for
a (backwards) stack, you would have a hard time using it. 'Push' op-codes
decrement the stack-pointer and 'pop' increments it regardless of
the characteristics of the stack-selector. I don't know if this is
a bug or a feature.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


