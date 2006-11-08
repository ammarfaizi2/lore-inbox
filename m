Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161725AbWKHTwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161725AbWKHTwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659AbWKHTwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:52:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754658AbWKHTwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:52:35 -0500
Date: Wed, 8 Nov 2006 11:50:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 0/2] MACB driver update
Message-Id: <20061108115039.58e7f6f5.akpm@osdl.org>
In-Reply-To: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
References: <20061108203358.558c28d3@cad-250-152.norway.atmel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 20:33:58 +0100
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Hi Andrew,
> 
> After Andrew Victor explained to me how at91rm9200 does hardware
> address initialization and phy probing, I decided to give it a go on
> avr32 as well. So here's one patch for the avr32 platform code and one
> for the actual macb driver which implements those changes.
> 
> I suspect that the avr32 platform patches might get messy, so feel free
> to drop them all

You'll need to be a lot more specific than "platform patches" and "them all".

Patches have names.  I currently have

gpio-framework-for-avr32.patch
avr32-spi-ethernet-platform_device-update.patch
avr32-move-spi-device-definitions-into-main-board.patch
atmel-spi-driver.patch
atmel-spi-driver-maintainers-entry.patch
avr32-move-ethernet-tag-parsing-to-board-specific.patch
atmel-macb-ethernet-driver.patch
adapt-macb-driver-to-net_device-changes.patch

I'd prefer to drop the lot, but we do have those SPI patches which David
needs to see.

> and pull from the master branch of
> 
> 	git://www.atmel.no/~hskinnemoen/linux/kernel/avr32.git master
> 
> instead. I won't put any new drivers or updates to drivers that are not
> in mainline there.
> 
> I will still post patches for the avr32 platform code just to show how
> things are affecting the platform-specific bits.
> 

So in fact I do think I'd prefer to drop everything.  How about

a) you sort out the SPI patches with David, send them over to me when
   it's ready and

b) everything else goes into Linus from your git tree, and I include
   your git tree in -mm?

(I hope that tree works, btw - for some reason it seems that any git tree
which isn't on kernel.org is down half the time).

