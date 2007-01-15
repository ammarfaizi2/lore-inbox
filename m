Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbXAONyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbXAONyL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbXAONyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:54:11 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:45987 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbXAONyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:54:09 -0500
Message-ID: <45AB8768.7000907@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2007 19:23:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: prioritize PCI traffic ?
References: <1168859265.15294.8.camel@localhost>
In-Reply-To: <1168859265.15294.8.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Soeren Sonnenburg wrote:
> Dear all,
> 
> is it possible to explicitly tell the kernel to prioritize PCI traffic
> for a number of cards in pci slots x,y,z ?
> 
> I am asking as severe ide traffic causes lost frames when watching TV
> using 2 DVB cards + vdr... This is simply due to the fact that the PCI
> bus is saturated...

How do you know that the bus is saturated?
Are you streaming data to/from the ide hard disks/CDROM?
Do you have DMAs 'ON' for the hard disks?
Is everything just fine if there are no IDE traffic?
Are you running 2.6 kernel with preempt 'ON'?
Are all hardware on the same IRQ line? (shared interrupts)

> So, is any prioritizing of the PCI bus possible ?

The drivers + application indirectly can control priority on the
bus.  Just reduce the priority of the application that uses IDE and
see if adjusting nice values of applications can change the scenario.

--Vaidy

> Best
> Soeren
> --
> Sometimes, there's a moment as you're waking, when you become aware of
> the real world around you, but you're still dreaming.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

