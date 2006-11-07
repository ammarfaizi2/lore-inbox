Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754200AbWKGLmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbWKGLmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbWKGLmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:42:09 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:31230 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1754200AbWKGLmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:42:07 -0500
Date: Tue, 7 Nov 2006 12:25:07 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 0/4] Atmel SPI driver and related AVR32 changes
Message-ID: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series contains a SPI master driver for the Atmel AT32/AT91 SPI
controller along with a GPIO API for avr32 and a few other changes this
driver depends on to work.

I have compile-tested the driver on arm, but someone please verify that
it works on at91 boards. It should be usable for both at91rm9200 and
at91sam926x after the necessary platform-specific code is added. David
sent me some code to do this on at91 once, but I dropped it from the
patch since I don't think it will work anymore. Please let me know if
you want med to send those changes as a separate patch anyway.

The driver has been tested with mtd_dataflash and a LCD panel driver on
atstk1000 (avr32). Unfortunately, I haven't been able to use it with
jffs2, as the jffs2 wbuf code BUGs on me with mtd_dataflash (this has
been reported by several people on linux-mtd, but there doesn't seem to
be a solution yet.)

I'd appreciate comments on both the SPI driver itself (big thanks to
David for all the comments I got so far) and the GPIO API. I think we
should work towards minimizing the differences between the at32 and
at91 gpio apis so that we can eliminate a few #ifdefs in the common
drivers.

Haavard
