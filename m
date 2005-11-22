Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVKVV5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVKVV5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVKVV5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:57:07 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:47234 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S965068AbVKVV46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:56:58 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com><20051122204918.GA5299@kroah.com><9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com><1132694935.10574.2.camel@localhost> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
Date: Tue, 22 Nov 2005 13:56:29 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Christmas list for the kernel
In-Reply-To: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0511221353560.31017@qynat.qvtvafvgr.pbz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com><20051122204918.GA5299@kroah.com><9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com><1132694935.10574.2.camel@localhost>
 <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Jon Smirl wrote:

> On 11/22/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
>>> Currently you have to compile most of this stuff into the kernel.
>> forgive my ignorance, but whats stopping you from doing this now?
>
> It would be better if all of the legacy drivers could exist on
> initramfs and only be loaded if the actual hardware is present. With
> the current code someone like Redhat has to compile all of the legacy
> support into their distribution kernel. That code will be present even
> on new systems that don't have the hardware.
>
> An example of this is that the serial driver is hard coded to report
> four legacy serial ports when my system physically only has two. I
> have to change a #define and recompile the kernel to change this.
>
> The goal should be able to build something like Knoppix without
> Knoppix needing any device probing scripts. Linux is 90% of the way
> there but not 100% yet.

umm, don't you realize that this just means that the device probing 
scripts go on the initrd? the kernel doesn't magicly decide which drivers 
to load, it uses scripts. especially with legacy and ISA devices there are 
no safe way to probe for them.

> X is also part of the problem. Even if the kernel nicely identifies
> all of the video hardware and input devices, X ignores this info and
> looks for everything again anyway. In a more friendly system X would
> use the info the kernel provides and automatically configure itself
> for the devices present or hotplugged. You could get rid of your
> xorg.cong file in this model.

this needs to be sent as a suggestion to xorg, but since they run on 
things besides Linux don't expect them to eliminate the config file 
(besides, how else do you override the defaults when you need to)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
