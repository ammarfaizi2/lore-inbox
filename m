Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSK1Bq4>; Wed, 27 Nov 2002 20:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSK1Bqz>; Wed, 27 Nov 2002 20:46:55 -0500
Received: from [204.221.110.13] ([204.221.110.13]:36283 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP
	id <S265065AbSK1Bqz> convert rfc822-to-8bit; Wed, 27 Nov 2002 20:46:55 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH ] - 2.5.49 - New serial driver ( Digi Intl. Realport).
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Wed, 27 Nov 2002 19:54:07 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E17D87A@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH ] - 2.5.49 - New serial driver ( Digi Intl. Realport).
Thread-Index: AcKWgRMV15ItOQRcQXSKVfEPrxuXHw==
From: "Scott Kilau" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Digi International would like to submit a new serial driver called Realport to the kernel tree.

We currently ship this driver as a source RPM bundle available on our web site.
The driver has been released for about 3 years now and is stable.

The Realport product/drivers have become one of the main products of Digi and
will be very actively supported by us.

A brief description of what the driver is/does:
>         This driver makes the serial ports on a Digi RealPort enabled
>         network product appear as though they are local tty devices  
>         directly attached to the local computer.

I have ported the driver up to 2.5.49,
(The new .49 module stuff was *very* interesting!)

The driver patch is quite large, so I have decided to have the patch put
on our ftp site for download. It can be downloaded from:
ftp://ftp.digi.com/support/techsupport/linux/linux-2.5.49-realport.diff.gz

Please let me know if someone accepts and adds this patch to the kernel,
so I can relay the good news to my powers-that-be.

The changes involved are very minimal to the linux source tree.
In fact, I can list them as follows:
1) Created new file called Documentation/digirealport.txt
2) Updated MAINTAINERS to include this new driver.
4) Updated drivers/char/Kconfig to include this new driver.
5) Updated drivers/char/Makefile to include this new driver.
6) Created new directory in drivers/char called digi_rp.
7) Put our Realport .c and .h files in this new directory.
8) Created a Makefile in this new directory.
9) Updated drivers/char/tty_io.c to include dgrp_init() for monolithic builds of the driver.

I have tested it as both a module (with the new modutils of course!), and as
a monolithic driver without any problems.

Finally, if there are any questions about the driver, source, etc,
please feel free to email me.

Thanks!
Scott Kilau
Digi International
