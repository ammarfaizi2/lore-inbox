Return-Path: <linux-kernel-owner+w=401wt.eu-S932336AbXAOOAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbXAOOAl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXAOOAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:00:41 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:50832 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbXAOOAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:00:40 -0500
Subject: Re: prioritize PCI traffic ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45AB8768.7000907@linux.vnet.ibm.com>
References: <1168859265.15294.8.camel@localhost>
	 <45AB8768.7000907@linux.vnet.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Jan 2007 15:00:30 +0100
Message-Id: <1168869630.15294.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 19:23 +0530, Vaidyanathan Srinivasan wrote:
> Soeren Sonnenburg wrote:
> > Dear all,
> > 
> > is it possible to explicitly tell the kernel to prioritize PCI traffic
> > for a number of cards in pci slots x,y,z ?
> > 
> > I am asking as severe ide traffic causes lost frames when watching TV
> > using 2 DVB cards + vdr... This is simply due to the fact that the PCI
> > bus is saturated...
> 
> How do you know that the bus is saturated?

I simply dd if=/dev/sd? of=/dev/null from four brand new sata-harddisks.

> Are you streaming data to/from the ide hard disks/CDROM?

yes.

> Do you have DMAs 'ON' for the hard disks?

yes.

> Is everything just fine if there are no IDE traffic?

yes.

> Are you running 2.6 kernel with preempt 'ON'?

no: CONFIG_PREEMPT_NONE=y

> Are all hardware on the same IRQ line? (shared interrupts)

no: libata devices are on IRQ 16 and DVB devices on IRQ 20

> > So, is any prioritizing of the PCI bus possible ?
> 
> The drivers + application indirectly can control priority on the
> bus.  Just reduce the priority of the application that uses IDE and
> see if adjusting nice values of applications can change the scenario.

That unfortunately did not help... no change...

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
