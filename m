Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRCTJ0K>; Tue, 20 Mar 2001 04:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCTJ0A>; Tue, 20 Mar 2001 04:26:00 -0500
Received: from [213.158.195.134] ([213.158.195.134]:39441 "EHLO
	plwawtl0.pl.ccbeverages.com") by vger.kernel.org with ESMTP
	id <S129134AbRCTJZt>; Tue, 20 Mar 2001 04:25:49 -0500
From: "Tomasz Sterna" <smoku@jaszczur.org>
Date: Tue, 20 Mar 2001 10:16:36 +0100
To: linux-kernel@vger.kernel.org
Subject: standard_io_resources[]
Message-ID: <20010320101636.A4226@plwawtl0.pl.ccbeverages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't find a maintainer of the code, so I'm writing here.

In kernel 2.4.1 in arch/i386/kernel/setup.c there is:

--- arch/i386/kernel/setup.c
struct resource standard_io_resources[] = {
        { "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
        { "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
        { "timer", 0x40, 0x5f, IORESOURCE_BUSY },
        { "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
        { "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
        { "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
        { "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
        { "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
};
---

which fix-allocate some io-resources.
What is the reason for that?
Isn't that a job of the device drivers?

In KGI we have our own keyboard driver which tries to allocate the 
kayboard I/O range for itself, and when it does io_check_region() it 
fails. What should I do?


-- 
http://www.jaszczur.org/~smoku/
