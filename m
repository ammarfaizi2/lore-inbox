Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVETUAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVETUAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVETUAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:00:14 -0400
Received: from alog0356.analogic.com ([208.224.222.132]:447 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261564AbVETUAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:00:06 -0400
Date: Fri, 20 May 2005 15:59:44 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Valdis.Kletnieks@vt.edu
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000 
In-Reply-To: <200505201945.j4KJjSAW014218@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0505201553420.6302@chaos.analogic.com>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <20050520141434.GZ2417@lug-owl.de> <Pine.LNX.4.61.0505201124230.5107@chaos.analogic.com>
            <Pine.LNX.4.62.0505202125440.18326@numbat.sonytel.be>
 <200505201945.j4KJjSAW014218@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 20 May 2005 21:26:59 +0200, Geert Uytterhoeven said:
>> On Fri, 20 May 2005, Richard B. Johnson wrote:
>
>>> I think that I've discovered a bug. I know that what I have written gets
>>> to the screen buffer because I can read in back! This doesn't make
>>> any sense.
>>
>> Even if it's only in the CPU cache, of course you can read it back (using the
>> CPU, not DMA ;-).
>
> No, the bug is in Richard's assuming that because he can read it back in means
> that it's in the screen buffer.  In fact, it only means he wrote it into some
> memory location that he can read back in. ;)
>
> Now if he added a description that verified that a read *from the screen
> buffer*
> (rather than "from where he wrote") shows his changes, *then* he'd have
> something...
>

Well MAP_FIXED must either mmap the physical location I provided or
it must fail. Since it didn't fail, I figure that it did what I
told it to do. Now, that "FIXED" refers to a fixed offset. Geert is
correct when he says that it's probably just in cache. Now begs
the question... Why would a hardware buffer ever be cached? That's
why I think I found a bug. It certainly shouldn't be cached.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5554.17 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
