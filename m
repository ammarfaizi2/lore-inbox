Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUBPRKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUBPRKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:10:09 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:18375 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S265898AbUBPRJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:09:59 -0500
Subject: Any guides for adding new IDE chipset drivers?
From: Alex Bennee <kernel-hacker@bennee.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1076951082.31859.60.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Mon, 16 Feb 2004 17:04:42 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We currently have implemented a simple (PIO) IDE interface on our
embedded SH based board. The "driver" is just a simple call from
ide_setup() that twiddles the various values in ide_hwifs to set the
correct port addresses.

All this is all well and good and works fine. However I'm looking at
adding DMA support to the driver to make better use of the hardware.
I've been looking around the other arch IDE drivers (e.g. the ppc pmac
driver) which seem to hook into the probe_for_hwifs() and then update
the hwifs table itself. This makes me wonder am I initialising my driver
the "correct" way.

As far as implementing the DMA features is concerned as far as I can
tell I just need to code up routines for all the various
hwifs[x].ide_dma* functions and be done with it. Am I missing anything?

So my questions boil down to:

Are there any guides for driver writers for what needs doing to add new
IDE chipset drivers?

Is there a driver that can be held of as an example of good taste and
the "right" way to implement a chipset driver?

Regards,


-- 
Alex, homepage: http://www.bennee.com/~alex/
"I am not sure what this is, but an `F' would only dignify it."
		-- English Professor

