Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRB0A5J>; Mon, 26 Feb 2001 19:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129372AbRB0A47>; Mon, 26 Feb 2001 19:56:59 -0500
Received: from [209.81.55.2] ([209.81.55.2]:63243 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129355AbRB0A4m>;
	Mon, 26 Feb 2001 19:56:42 -0500
Date: Mon, 26 Feb 2001 16:56:38 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Serial List <linux-serial@vger.kernel.org>
Subject: CLOCAL and TIOCMIWAIT
Message-ID: <Pine.LNX.4.10.10102261651000.15230-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

A customer has just brought to my attention that when you try to use the
TIOCMIWAIT ioctl with our boards and CLOCAL is enabled, you can't check
changes in the DCD signal. He also mentioned that that is possible with
the regular serial ports.

As I understood, CLOCAL meant disabling DCD sensitivity, so if CLOCAL is
disabled, no changes in DCD will be passed from hardware driver to the
kernel or userspace. The way the serial driver is implemented, this is not
true (i.e. even with CLOCAL enabled, you can still see DCD changes through
the TIOCMIWAIT command).

My question is: what's the correct interpretation of CLOCAL?? If the
serial driver's interpretation is the correct one, I'll be more than happy
to change the Cyclades' driver to comply with that, I just want to make
sure that this is the expected behavior before I patch the driver.

Thanks in advance for your comments.

Later,
Ivan

