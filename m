Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261270AbREOS3J>; Tue, 15 May 2001 14:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbREOS3A>; Tue, 15 May 2001 14:29:00 -0400
Received: from [206.14.214.140] ([206.14.214.140]:8453 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261261AbREOSXc>; Tue, 15 May 2001 14:23:32 -0400
Date: Tue, 15 May 2001 11:19:17 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151031320.2112-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10105151046240.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And my opinion is that the "hot-plugged" approach works for devices even
> if they are soldered down - the "plugging" event just always happens
> before the OS is booted, and people just don't unplug it. 

I absolutely agree with you. This is the way I always think of devices.

> Now, if we just fundamentally try to think about any device as being
> hot-pluggable, you realize that things like "which PCI slot is this device
> in" are completely _worthless_ as device identification, because they
> fundamentally take the wrong approach, and they don't fit the generic
> approach at all.
>
> But this is also why I don't think static device numbers make any
> sense. It's silly to have the same disk show up as different devices just
> because it is connected to a different kind of controller. And it is
> _really_ silly to statically pre-allocate device numbers based on the
> "location" of a device. 

   I agree. It gets worse when we consider multiple bus and NUMA machines.
On a NUMA system you have to ask yourself how should a piece of hardware
look from the node it is on and from another node. Should they look the
same. Then their is the visiblity issue. Which node can see this piece of
hardware? Some devices span several nodes, some only one node. Then on
some NUMA systems you can setup "raid" like systems. If one peice of
hardware fails on a node then another piece of hardware on some other node 
that was caching the hardware state of the hardware that just falied takes
over. Then we have the famous ISA devices in multiple PCI bus systems.
NUMA systems with nodes that multiple buses would just compound the
problem.
 

