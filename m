Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbTESSMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTESSMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:12:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262638AbTESSMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:12:34 -0400
Date: Mon, 19 May 2003 14:25:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI mapping on large memory 32-bit machines
In-Reply-To: <3EC91F3B.8010005@techsource.com>
Message-ID: <Pine.LNX.4.53.0305191419250.148@chaos>
References: <3EC91F3B.8010005@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Timothy Miller wrote:

> On x86 with PAE and 4 gigs of RAM or more, where do memory-mapped I/O
> devices get mapped (in the physical address space)?  Most PCI devices
> can't handle 64-bit addresses.  Can PC chipsets physically remap some of
> the RAM to above 4 gig?  Or do you just lose that much RAM?  If both RAM
> and some I/O device are mapped to the same location, isn't there a conflict?
>

The answer to PC/PCI is that the I/O space set (usually by the BIOS)
into the BARs removes any RAM visibility in that area. But.... this
is BAD bacause the BIOS may still claim that there is 4 gig of RAM.
The OS may then try to use it. To "solve" this problem, Win/tell started
the "high-RAM" specification where RAM higher than XXX Megs gets
mapped with page-registers. The problem is that "XXX" is board-specific!

So, to answer your entire question... don't do it! Only use 3 gigs max
and you will not be confused by confused hardware!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

