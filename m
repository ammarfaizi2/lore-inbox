Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbRBGVPz>; Wed, 7 Feb 2001 16:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbRBGVPp>; Wed, 7 Feb 2001 16:15:45 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:20996 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129786AbRBGVPd>; Wed, 7 Feb 2001 16:15:33 -0500
Date: Thu, 8 Feb 2001 00:12:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 pdev_enable_device() call in setup-bus.c
Message-ID: <20010208001202.A976@jurassic.park.msu.ru>
In-Reply-To: <200102071950.LAA05408@milano.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102071950.LAA05408@milano.cup.hp.com>; from grundler@cup.hp.com on Wed, Feb 07, 2001 at 11:50:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 11:50:52AM -0800, Grant Grundler wrote:
> Can you explain why pci_assign_unassigned_resources()
> calls pdev_enable_device() for every PCI device instead
> of having each PCI *driver* call pci_enable_device()
> as part of driver initialization?

Mainly because there are driverless devices like display adapters,
PCI bridges, or PCI devices with legacy drivers (IDE, for example).

OTOH, pdev_enable_device() most likely will be removed, but
it's 2.5 material.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
