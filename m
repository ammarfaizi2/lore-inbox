Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSLQTlX>; Tue, 17 Dec 2002 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSLQTlX>; Tue, 17 Dec 2002 14:41:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62602 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267078AbSLQTlU>; Tue, 17 Dec 2002 14:41:20 -0500
Date: Tue, 17 Dec 2002 14:52:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <1040154273.20804.13.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1021217144308.26554A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Dec 2002, Alan Cox wrote:

> On Tue, 2002-12-17 at 18:48, Ulrich Drepper wrote:
> > Alan Cox wrote:
> > 
> > > Is there any reason you can't just keep the linker out of the entire
> > > mess by generating
> > > 
> > > 	.byte whatever
> > > 	.dword 0xFFFF0000
> > > 
> > > instead of call ?
> > 
> > There is no such instruction.  Unless you know about some secret
> > undocumented opcode...
> 
> No I'd forgotten how broken x86 was
> 

You can call intersegment with a full pointer. I don't know how
expensive that is. Since USER_CS is a fixed value in Linux, it
can be hard-coded

		.byte 0x9a
		.dword 0xfffff000
		.word USER_CS

No. I didn't try this, I'm just looking at the manual. I don't know
what the USER_CS is (didn't look in the kernel) The book says the
pointer is 16:32 which means that it's a dword, followed by a word.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


