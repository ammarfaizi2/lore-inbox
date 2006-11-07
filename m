Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753869AbWKGN7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbWKGN7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbWKGN7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:59:07 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:4308 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1753869AbWKGN7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:59:03 -0500
Date: Tue, 7 Nov 2006 14:49:42 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 0/3] Atmel MACB ethernet driver for avr32
Message-ID: <20061107144942.25c2db42@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's another driver for Atmel on-chip hardware: the MACB ethernet
controller. This is present in the at32ap7000 chip, as well as (I
think) at91sam926x. It is somewhat similar to the one in at91rm9200,
but the DMA engine is different.

It might make sense to share at least some of the code between the
existing emac driver for at91rm9200 and this one.

As with the spi driver I sent earlier today, I'm including some changes
to avr32 necessary for this driver to actually work. These changes
should go in after the spi changes in the queue or it might conflict.
If this causes any trouble, feel free to just drop them and I'll see if
I can organize things differently.

The last patch in the series adapts the macb driver to the driver model
changes in gregkh-driver-network-device.patch. I didn't fold this into
the driver patch in case someone wants to pick it out and use it on
a 2.6.19-rc kernel.

As always, I really appreciate any comments you may have.

Oh, and this patch even updates MAINTAINERS. I forgot to do that with
the SPI driver, will post an update in a moment.

Haavard
