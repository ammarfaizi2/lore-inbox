Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbTAQPQ6>; Fri, 17 Jan 2003 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbTAQPQ6>; Fri, 17 Jan 2003 10:16:58 -0500
Received: from fmf01.fwn.rug.nl ([129.125.22.50]:1802 "EHLO fmf01.fwn.rug.nl")
	by vger.kernel.org with ESMTP id <S267518AbTAQPQ5>;
	Fri, 17 Jan 2003 10:16:57 -0500
Date: Fri, 17 Jan 2003 16:26:02 +0100 (CET)
From: Erik Logtenberg <erik@fmf.nl>
To: linux-kernel@vger.kernel.org
Subject: flaw in documentation drivers/net/dummy.c
Message-ID: <Pine.LNX.4.44.0301171614330.5369-100000@fmf01.fwn.rug.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel developers,

I noticed that the documentation of dummy.c (the dummy network device) is 
somewhat flawed. In the help you can pop up in 'make menuconfig' it says:

> This is essentially a bit-bucket device (i.e. traffic you send to
> this device is consigned into oblivion)

While in fact it seems to behave as a loopback device, so traffic is not 
at all consigned into oblivion, it simply loops back, just like the 'lo' 
network device.

Furthermore it says:

> It won't enlarge your kernel either. What a deal.

While in fact ofcourse it does. (I mean dummy.c does contain some code 
after all) In my case, it added 144 bytes to my kernel.

And in dummy.c itself, the comments say:

>        [when not running slip]
>                ifconfig dummy slip.addr.ess.here up
>        [to go to slip]
>                ifconfig dummy down
>                dip whatever

While in fact, one would have to call the device 'dummy0' instead of 
'dummy'. Not a very big issue, but it did take me a while before I noticed 
it. (I usually assume it's my own error, before I start looking for 
possible errors in the howto's)

I hope someone could fix up these tiny flaws, when he or she has a minute 
to spare.


Kind regards,

Erik Logtenberg.




