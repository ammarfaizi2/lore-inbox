Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSFDPdu>; Tue, 4 Jun 2002 11:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSFDPdt>; Tue, 4 Jun 2002 11:33:49 -0400
Received: from vivi.uptime.at ([62.116.87.11]:26797 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S313743AbSFDPds>;
	Tue, 4 Jun 2002 11:33:48 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Patrick Mochel'" <mochel@osdl.org>
Cc: <axp-kernel-list@redhat.com>,
        "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
        <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Date: Tue, 4 Jun 2002 17:33:36 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <001e01c20bdd$34dad5f0$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <Pine.LNX.4.33.0206040749530.654-100000@geena.pdx.osdl.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> [ I apologize for answering this so late, and being so tardy 
> in releasing 
> docs explaining all this. I'll be sending docs to the list soon... ]

Alright. This is OK. :o)

[ ... ]

> The short of it: 2.5.19 introduced a struct bus_type that 
> describes each
> bus type in the system. It holds lists of all the devices and 
> drivers that are found for that bus type.

I guessed so and already found this out. :o)

[ ... ]

> The arch/ objects are probably linked before  the driver/
> objects on alpha, so the bus ends up being scanned before the 
> bus type is registered.

Seems, that you're right!

> Can pcibios_init() be demoted to a device_initcall? This would delay 
> probing until all the subsystems could be setup...

Yea, great idea, but I don't have the time at the moment to do this.
I hope anybody else will (please) do it!?

-Oliver


