Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWJPW51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWJPW51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWJPW51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:57:27 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:1196 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422662AbWJPW5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:57:25 -0400
Date: Tue, 17 Oct 2006 00:56:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
In-Reply-To: <20061016.153720.115911255.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0610170053280.30479@yvahk01.tjqt.qr>
References: <20061016164124.GC9350@pelagius.h-e-r-e-s-y.com>
 <20061016.135400.112621150.davem@davemloft.net> <Pine.LNX.4.61.0610162358270.30479@yvahk01.tjqt.qr>
 <20061016.153720.115911255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I have not seen this soft lockup so far, though I run a 2.6.16, most 
>> likely using CONFIG_PROM_CONSOLE (redirected to ttya by prom) because
>> the machine is not a SUN4V (which SUNHV seems to be for).
>
>You could be using one of the other serial drivers.
>Check the boot messages and your kernel config.

Thanks for the hint. I am still a bit puzzled why there are so many 
serial ports detected even though there is only ttya and ttyb on the 
back:

Console: switching to mono PROM 80x24
su0 at 0x000001fff13062f8 (irq = 5,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
ttyS0 at MMIO 0x1fff1400000 (irq = 7901920) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
ttyS1 at MMIO 0x1fff1400040 (irq = 7901920) is a SAB82532 V3.2
ttyS2 at MMIO 0x1fff1200000 (irq = 7901664) is a SAB82532 V3.2
ttyS3 at MMIO 0x1fff1200040 (irq = 7901664) is a SAB82532 V3.2

One of them may actually be the mouse though currently no [SUN4] 
keyboard (and hence no mouse) is attached.



	-`J'
-- 
