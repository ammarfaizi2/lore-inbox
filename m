Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311642AbSCTPRD>; Wed, 20 Mar 2002 10:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311643AbSCTPQw>; Wed, 20 Mar 2002 10:16:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31943 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311642AbSCTPQp>;
	Wed, 20 Mar 2002 10:16:45 -0500
Date: Wed, 20 Mar 2002 16:38:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Manon Goo <manon@manon.de>
Cc: arrays@compaq.com, <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>,
        =?ISO-8859-1?Q?Markus_Schr=F6der?= <schroeder.markus@allianz.de>
Subject: Re: Hooks for random device entropy generation missing in cpqarray.c
In-Reply-To: <4461574.1016634817@eva.dhcp.gimlab.org>
Message-ID: <Pine.LNX.4.44.0203201630100.1268-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Manon Goo wrote:

> All hooks for the random ganeration (add_blkdev_randomness() ) are ignored 
> in the cpqarray / ida  driver.
> 	Is a patch available ?
> 	or an other updated driver ?
> 	any hints where to put add_blkdev_randomness() in your driver ?

Its all handled by drivers/scsi/scsi_lib.c, its a generic service so is 
done for all drivers.

> is add_interrupt_randomness() called on an i386 SMP IO-APCI system ?

Yes, check out arch/i386/kernel/irq.c:handle_IRQ_event, irq.c is the 
generic code which sits on top of the real interrupt controller driver, be 
it an IOAPIC or regular PIC.

Cheers,
	Zwane


