Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263191AbTC1WyC>; Fri, 28 Mar 2003 17:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbTC1WyC>; Fri, 28 Mar 2003 17:54:02 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:27316 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S263191AbTC1WyA>;
	Fri, 28 Mar 2003 17:54:00 -0500
Date: Sat, 29 Mar 2003 00:05:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 3c59x gives HWaddr FF:FF:...
Message-ID: <20030328230510.GA5124@werewolf.able.es>
References: <20030328145159.GA4265@werewolf.able.es> <20030328124832.44243f83.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030328124832.44243f83.akpm@digeo.com>; from akpm@digeo.com on Fri, Mar 28, 2003 at 21:48:32 +0100
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.28, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > Hi all...
> > 
> > I have just switched the network card for my internal network from a 8139
> > to a 3c905C-TX/TX-M. The 3c59x driver gives the buggy FF:FF:FF:FF:FF:FF
> > hardware address for the adapter. I had heard about the problem and looked
> > throug LKML archives, but they just point to a non existen web page.
> > I use 2.4.21-pre6+aa.
> > 
> > What happens ? Any solution available ?
> > 
> 
> The eeprom wasn't powered up.
> 
> Please take the 2.4.20 3c59x.c and place that into the 2.5 tree and confirm
> that it does the same thing (it will).
> 

Hum, I suppose you want to say take the _2.5_ one and put into my _2.4_ tree ?
Some previous answer also talked about a more recent version in -ac.
(btw, can 2.5 be useful for something ? does not the driver depend on a new
arch of, for example, the PCI layer ? )

> Then try disabling APCI and/or otherwise fiddling with your power management
> options (maybe in BIOS too).
> 

I don't build ACPI, just APM power-off (SMP box).
Will take a look at 2.4-ac (it looks like the most similar thing to what I have)
and to 2.5.

Thanks for your info.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
