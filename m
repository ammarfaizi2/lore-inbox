Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267894AbRG0Jha>; Fri, 27 Jul 2001 05:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267906AbRG0JhY>; Fri, 27 Jul 2001 05:37:24 -0400
Received: from c290168-a.stcla1.sfba.home.com ([24.250.174.240]:11847 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S267894AbRG0JhJ>; Fri, 27 Jul 2001 05:37:09 -0400
From: brian@worldcontrol.com
Date: Fri, 27 Jul 2001 02:43:41 -0700
To: linux-kernel@vger.kernel.org
Subject: Known bugs in 2.4.6 serial driver?
Message-ID: <20010727024341.A2169@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I just found on my laptop that using the serial port interferes
with the mouse pointer.

My mouse is on /dev/psaux (PS/2 style) and my serial port is on
/dev/ttyS0.

At first I figure it was my app.  But then I found similar behavior
while running a similar app in vmware under Windows 98.  I.E.
when the windows app used the serial port via vmware, the mouse
pointer went all haywire whether its was focused in vmware or
elsewhere.

My PS/2 mouse is on irq 12, will the serial port is in irq 4
like it is supposed to be.

My app makes extensive use of tcdrain, read, and write while
more or less in raw mode on the serial port.

My app also works fine so long as I don't move the mouse while
it is running.

Anyone heard of something similar?  Or is their an error in
the design of my laptop?

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
