Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSIJS60>; Tue, 10 Sep 2002 14:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSIJS60>; Tue, 10 Sep 2002 14:58:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318026AbSIJS6Z>; Tue, 10 Sep 2002 14:58:25 -0400
Date: Tue, 10 Sep 2002 12:03:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <1031683480.31787.107.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Sep 2002, Alan Cox wrote:
> 
> It drops you politely into the kernel debugger, you fix up the values
> and step over it. If you want to debug with zen mind power and printk
> feel free. For the rest of us BUG() is fine on SMP

Ok, a show of hands.. 

Of the millions (whatever) of Linux machines, how many have a kernel 
debugger attached? Count them.

In other words, if a user is faced with a dead machine with no other way
to even know what BUG() triggered than to try to set up a cross debugger,
just how useful is that BUG()? I claim it is pretty useless - simply
because 99+% of all people won't even make a bug report in that case,
they'll just push the reset button and consider Linux unreliable.

In other news, the approach that shows up in the kernel logs might just 
eventually be noticed and acted upon (especially if the machine acts 
strange and kills processes).

So I claim a BUG() that locks up the machine is useless. If the user can't
just run ksymoops and email out the BUG message, that BUG() is _not_ fine
on SMP.

It has nothing to do with zen mind power or printk's. It has everything to 
do with the fact that a working machine is about a million times easier to 
debug on than a dead one, _and_ is a lot more likely to get acted upon by 
most users.

		Linus

