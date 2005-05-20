Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVETPbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVETPbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVETPbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:31:37 -0400
Received: from alog0374.analogic.com ([208.224.222.150]:14533 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261347AbVETPb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:31:29 -0400
Date: Fri, 20 May 2005 11:31:15 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <20050520141434.GZ2417@lug-owl.de>
Message-ID: <Pine.LNX.4.61.0505201124230.5107@chaos.analogic.com>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <20050520141434.GZ2417@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Jan-Benedict Glaw wrote:

> On Fri, 2005-05-20 09:48:35 -0400, Richard B. Johnson <linux-os@analogic.com> wrote:
>>     len = getpagesize();
>>     if((fd = open("/dev/mem", O_RDWR)) == FAIL)
>>         ERRORS("open");
>>     if((sp = mmap((void *)SCREEN, len, PROT, TYPE, fd, SCREEN))==MAP_FAILED)
>>         ERRORS("mmap");
>
> Maybe you'd better not fiddle with physical memory, but use the device
> abstraction that's ment to offer that interface? That is, use a
> framebuffer driver and open /dev/fb* .
>
> MfG, JBG

No room for any more drivers. This just writes to a small LCD on an
embedded controller. There should be no reason why I can't
write directly to the physical memory. Anything written to the
physical screen buffer will show up on the screen, as long
as page zero is selected.

I think that I've discovered a bug. I know that what I have written gets
to the screen buffer because I can read in back! This doesn't make
any sense.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
