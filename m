Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSFSQOx>; Wed, 19 Jun 2002 12:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317924AbSFSQOw>; Wed, 19 Jun 2002 12:14:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26754 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317922AbSFSQOu>; Wed, 19 Jun 2002 12:14:50 -0400
Date: Wed, 19 Jun 2002 12:17:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: GPL module question
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840643@es06snlnt>
Message-ID: <Pine.LNX.3.95.1020619120029.16215A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Shipman, Jeffrey E wrote:

> I hope this is not off-topic. If it is, please point
> me in the right direction.
> 
> I'm currently writing a Linux Kernel module. Does
> this have to be under the GPL because it uses kernel
> routines? I really don't know of a way around
> using kernel routines because that's whatcha gotta
> do inside the kernel. :)
> 
> Hopefully this won't be an issue (it's not classified
> material or anything). I'm still waiting for my
> manager to get back to me on it.
> 
> Jeff Shipman - CCD
> Sandia National Laboratories
> (505) 844-1158 / MS-1372
> 

My read on this is that you can do anything you want for your own
local purposes. It's just like whatever you do in your bedroom
is your business.

Now, if you intend to make a product that needs the module so
it can work, then it should be written/released under GPL or
some similar license that lets user's look at and possibly modify
the source-code.

The operative word is "should" and here's the rub; It is possible
that to divulge the source-code would expose company trade secrets.
For instance, lets say your company invented a portable network
transceiver that does spread-spectrum, with signals so far down
into the noise that nobody could intercept them except the intended
receiver. To do this, you used an old-fashion 8250 UART in a strange
way. If you were to publish the source-code of the interface, then
everybody would know that the "secret" macro-cell in the custom
chip was just an obsolete UART. Your intellectual property is stolen,
you are out of business, and some Pacific rim company lives happily
ever-after off from your work.

So, to protect yourself from this, it is possible to make a wrapper
around your specific device that has to be protected, and release
this as an object file. This gets linked with the other stuff from
your published source-code.

You should expect a lot of persons to bitch-and-moan if you have to
supply an object file instead of some source, but if the product and
the module necessary to support it is very useful, most will "put up
and shut up".


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

