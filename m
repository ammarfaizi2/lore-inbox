Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130098AbRARDYE>; Wed, 17 Jan 2001 22:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130163AbRARDXz>; Wed, 17 Jan 2001 22:23:55 -0500
Received: from live.wasp.net.au ([202.61.164.12]:11791 "EHLO
	live.networx.net.au") by vger.kernel.org with ESMTP
	id <S130098AbRARDXq>; Wed, 17 Jan 2001 22:23:46 -0500
Date: Thu, 18 Jan 2001 11:23:32 +0800 (WST)
From: Matt Kemner <kemner@live.wasp.net.au>
To: <bandit2@iname.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Overriding BIOS settings with kernel 2.4.0
In-Reply-To: <Pine.LNX.4.21.0101171057580.2640-100000@bandit.dnsq.org>
Message-ID: <Pine.LNX.4.30.0101181114540.4158-100000@live.wasp.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001 bandit2@iname.com wrote:

bandit> 	I'm telling you all this because my BIOS keeps assigning shared
bandit> interrupts between the Geforce-TVCapture and NE2000-USB Hubs.

Look in your mainboard manual

I think you'll find that the PCI/AGP slots you are using for these devices
share IRQs because they are physically linked together.

I don't know about the AOPEN board, but on an ASUS P3B-F for example, the
AGP slot and PCI1 share their IRQ, and PCI slots 3&6 and 4&5 also share
so if you put devices in all of these slots, some devices will share
interrupts.

The only workaround is to pick different slots, and/or to not have more
than 4 devices in your system that don't like to share interrupts with
anything else.

 - Matt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
