Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTA1OQ3>; Tue, 28 Jan 2003 09:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTA1OQ3>; Tue, 28 Jan 2003 09:16:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63123 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265484AbTA1OQ0>; Tue, 28 Jan 2003 09:16:26 -0500
Date: Tue, 28 Jan 2003 09:27:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: nitin kumbhar <nkumbhar@rediffmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: driver address space
In-Reply-To: <20030128140611.31677.qmail@webmail7.rediffmail.com>
Message-ID: <Pine.LNX.3.95.1030128092300.21466A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2003, nitin  kumbhar wrote:

> Hello,
>  	I have a small query about kernel image organization. i am 
> using
> 2.4.7 kernel version.Is there any data structure in kernel which 
> will give
> information about _all_ kernel symbols? i could get the data 
> structure
> which gives _exported_ symbols only. But not all symbols. Using 
> this
> structure i want to access information about functions present in 
> a driver,
> which can be used to find out address range(_start_address_ &
> _end_address_) of the driver in kernel address space.
>  	It is possible to get this information about functions in a 
> driver
> using System.map. to get this information into kernel can we push 
> the
> content of this file into kernel image? i think this can be done 
> either by
> putting it at specific address or appending the image. Will it be 
> OK to
> access System.map(all kernel symbols) in this way from kernel? 
> Could
> this cause any security or some other problems?
>  	Or apart from this is there any other way to find out driver's
> address range in the kernel?
> 
>  	I hope this not something totally out of context. Thank You.
> 
> Regards,
> Nitin
> 

Since it's dynamic, i.e., the addresses depends upon other
drivers/modules being loaded before yours, you just make an ioctl()
that returns anything you want, including the virtual or even physical
address of anything in your driver.

That said, if you need to know where the driver is located in
the kernel, then something is definitely broken. Perhaps you are
trying to follow a panic() and want to see if it came from some
specific driver?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


