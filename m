Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277204AbRJDSzU>; Thu, 4 Oct 2001 14:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277207AbRJDSzK>; Thu, 4 Oct 2001 14:55:10 -0400
Received: from cs.columbia.edu ([128.59.16.20]:37010 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S277204AbRJDSzD>;
	Thu, 4 Oct 2001 14:55:03 -0400
Date: Thu, 4 Oct 2001 14:55:28 -0400
Message-Id: <200110041855.f94ItSH11421@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110040751040.9341-100000@shell.cyberus.ca>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001 07:54:19 -0400 (EDT), jamal <hadi@cyberus.ca> wrote:

> Has nothing to do with specific hardware although i see your point.
> send me an eepro and i'll at least add hardware flow control for you.
> The API is simple, its up to the driver maintainers to use. This
> discussion is good to make people aware of those drivers.

A bit of documentation for the hardware flow control API would help as 
well. The API might be fine and dandy, but if all you have is a couple of 
modified drivers -- some of which are not even in the standard kernel -- 
then you can bet not many driver writers are going to even be aware of it, 
let alone care to implement it.

For instance: in 2.2.19, the help text for CONFIG_NET_HW_FLOWCONTROL says 
only tulip supports it in the standard kernel -- yet I can't find that 
support anywhere in drivers/net/*.c, tulip.c included.

In 2.4.10 tulip finally supports it (and I'm definitely going to take a 
closer look), but that's about it. And tulip is definitely the wrong 
example to pick if you want a nice and clean model for your driver.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
