Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVAMLuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVAMLuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVAMLuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:50:32 -0500
Received: from alog0235.analogic.com ([208.224.220.250]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261599AbVAMLuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:50:18 -0500
Date: Thu, 13 Jan 2005 06:49:50 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Dimitris Lampridis <soth@softhome.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI lost interrupts and PLX chips
In-Reply-To: <1105573129.3218.11.camel@localhost>
Message-ID: <Pine.LNX.4.61.0501130647420.10398@chaos.analogic.com>
References: <1105573129.3218.11.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Dimitris Lampridis wrote:

> Hi everybody,
> I noticed a conversation some days ago that also mentioned something
> about PLX chips and a certain problem resulting in loss of interrupt
> signals.
>
> I'm writing a driver for a PCI-based device (an embedded USB Host
> Controller) and it uses a PLX bridge (device ID 5406). Although I've set
> up the device correctly and a logical analyzer shows the interrupts
> being generated on the USB HC chip, nothing comes past the bridge, thus
> nothing reaches the system. I use a typical pci_enable_device() followed
> but some request_region() and of course request_irq() on a kernel
> 2.6.10-rc3 (i386 system, VIA KT133, no APIC...)
> Does this have something to do with the discussion about PLX chips
> mentioned above? If it does, can anybody make clear what I have to do to
> see those interrupts coming?
>
> You can find the mail in question at:
> http://seclists.org/lists/linux-kernel/2005/Jan/0792.html
>
> Thanks,
> Dimitris

Make sure you execute pci_enable_device() __before__ you believe
the IRQ number in the structure.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
