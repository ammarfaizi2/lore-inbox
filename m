Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136778AbRAHHIg>; Mon, 8 Jan 2001 02:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136990AbRAHHI1>; Mon, 8 Jan 2001 02:08:27 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:49676 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S136778AbRAHHII>; Mon, 8 Jan 2001 02:08:08 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 08:07:50 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.0test12: problems timing events
Message-ID: <3A59754A.17115.89E77@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to time events inside the kernel in 2.4.0test12:

Basically the same code works fine in 2.2.18 with about 1us jitter. 
However in 2.4.0test12 the jitter is around 600ms!

What I did is this: I modified the interrupt routine of the serial 
driver to get a precision time-stamp via do_gettimeofday().

So I guess either interrupts are delayed significantly from time to 
time, or the time routine has been changed to be no longer useful 
within interrupt routines.

If anybody can enlighen me on this, I'd be happy.

I'm not subscribed to linux-kernel, so maybe please CC:

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
