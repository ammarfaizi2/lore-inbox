Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSK0VHD>; Wed, 27 Nov 2002 16:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSK0VHD>; Wed, 27 Nov 2002 16:07:03 -0500
Received: from mail10b.sbc-webhosting.net ([209.238.184.74]:17304 "HELO
	mail10b.sbc-webhosting.net") by vger.kernel.org with SMTP
	id <S264838AbSK0VHC>; Wed, 27 Nov 2002 16:07:02 -0500
Message-ID: <3DE53561.7020001@hornyaksys.com>
Date: Wed, 27 Nov 2002 16:13:05 -0500
From: Linux Geek <linux-geek@hornyaksys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about copy_from/copy_to
References: <Pine.LNX.3.95.1021127154031.4051A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Thanks fpr your response,

Yup, it's "political" this project is "work for hire" for an internal 
system - the code will never be distributed - all very hush hush. (I 
signed a non-disclosure agreement - so I can't be too specific.)

In essence, memory is allocated for each minor device number (total 
number of minors and the values are unknown at init time), and the data 
stored in a linked list. So for each open, the list is searched, and if 
the minor number is found, that is what is used (and a counter 
incremented), otherwise memory is allocated ad added to the list. (BTW - 
this is not my design and they're paying the bill.)

On the close the memory counter is decremented for the minor, and if 
zero, the memory is deallocated, So, it sounds like this is OK,

Richard B. Johnson wrote:
>... 
> So, I would say that it's not a good idea to allocate memory during
> an open(). If you some political reason, you are forced to do this,
> you need to count the number of open/close operations and only
> deallocate memory after the final close. There are atomic-counter
> macros you can use for this.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>    Bush : The Fourth Reich of America
> 
> 


