Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQLGHPY>; Thu, 7 Dec 2000 02:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQLGHPO>; Thu, 7 Dec 2000 02:15:14 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:9994 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129581AbQLGHPB>; Thu, 7 Dec 2000 02:15:01 -0500
Message-ID: <3A2F3174.60205@megapathdsl.net>
Date: Wed, 06 Dec 2000 22:43:00 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012061814020.7391-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> On Wed, 6 Dec 2000, Miles Lane wrote:
> 
>> Here is what goes wrong:
>> 
>> Dec  6 04:21:32 agate kernel: eth0: Host error, FIFO diagnostic register  0000.
> 
> 
> But it continues to work, right?

I'll check.  My system only has 80MB RAM, and I run Mozilla, which
pushes a lot of information into the swap space.  When I encounter
this "Host error" problem, tons of messages start spewing into my
logs.  This bogs my entire system down horribly.

<great educational material snipped>

I have reproduced this problem with all the drivers built
into the kernel.

I have also just tried a test pass with 3c59x built in and
USB built as modules.  I booted with only the 3c575 inserted.
I got eth0 running and then loaded usb-ohci (with the enable
bus mastering change added).  This resulted in modprobe hanging
again.

Now I'll try with all modules again and check to see whether eth0
is still usable.

Thanks,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
