Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRBGUoG>; Wed, 7 Feb 2001 15:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130647AbRBGUnq>; Wed, 7 Feb 2001 15:43:46 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:25830 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129945AbRBGUnm>; Wed, 7 Feb 2001 15:43:42 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102072042.f17KgKW03277@devserv.devel.redhat.com>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
To: root@chaos.analogic.com
Date: Wed, 7 Feb 2001 15:42:20 -0500 (EST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), davej@suse.de,
        alan@redhat.com (Alan Cox), becker@scyld.com,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.3.95.1010207152715.2498A-100000@chaos.analogic.com> from "Richard B. Johnson" at Feb 07, 2001 03:30:07 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I stand by my statement. PCI devices that require resources are
> required to provide read/write registers indicating these resources
> whether or not the enable bits are set. This is mandatory. 

And the assignment of those resources is done by pci_enable_device. So
looking at the irq data or the BAR assignment until pci_enable_device
has done its work doesnt tell you anything meaningful

It doesnt just flip the IO and MEM bits

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
