Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTIIReI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTIIReI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:34:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7553 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264331AbTIIReF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:34:05 -0400
Date: Tue, 9 Sep 2003 13:36:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Adam Litke <agl@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Determining pci bus from irq
In-Reply-To: <1063127380.30397.69.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0309091322230.8129@chaos>
References: <1063123832.2037.40.camel@dyn318261bld.beaverton.ibm.com>
 <1063127380.30397.69.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Alan Cox wrote:

> On Maw, 2003-09-09 at 17:10, Adam Litke wrote:
> > Is there a nice way to determine, given an irq number, the pci bus
> > number that raised the interrupt?
>
> In general the answer is you can't find out. PCI IRQ lines are shared.
> You can certainly lock and walk the pci device list looking for matches
> but you may get a lot of devices on different busses
>

Unless you've got a 'scope. If a device is interrupting often
or if it can be made to interrupt. you can look at the pin on
the PCI card. For some reason, on ix86, the logical "pin" is
always "A", regardless of the device, so you only have one
interrupt line connected to each slot. On lap-tops, there is
often only one IRQ shared for everything IRQ9 for Compaq.

These interrupt lines are usually not physically connected
together. They are ORed in some glue chip so you can see
what card is actually operating the line. On PCI, the IRQ
pin is (+) for TRUE, normally pulled down, and never floating.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


