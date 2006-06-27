Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932942AbWF0JFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbWF0JFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933015AbWF0JFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:05:30 -0400
Received: from donkey.symmetric.co.nz ([202.21.16.3]:16597 "EHLO
	donkey.symmetric.co.nz") by vger.kernel.org with ESMTP
	id S932942AbWF0JF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:05:29 -0400
Message-ID: <44A0F4CC.2000606@symmetric.co.nz>
Date: Tue, 27 Jun 2006 21:05:16 +1200
From: Ben Martel <benm@symmetric.co.nz>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Patrick McFarland <diablod3@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Charles Majola <chmj@rootcore.co.za>,
       Pavel Machek <pavel@ucw.cz>, stephen@blacksapphire.com,
       kernel list <linux-kernel@vger.kernel.org>, radek.stangel@gmsil.com
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
References: <20060616094516.GA3432@elf.ucw.cz> <449BEABD.5010305@rootcore.co.za> <1151070837.4549.18.camel@localhost.localdomain> <200606270437.59454.diablod3@gmail.com>
In-Reply-To: <200606270437.59454.diablod3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Y'all,

I have had a look at the changes to the 2.6.1{6,7} kernel to do with the 
buffering and I think that this driver will benefit greatly from the 
changes away from the flip/flop scheme.

When Steve and I originally wrote the driver it always seemed to be 
limited throughput wise, due to the inefficient char handling it did.

Good luck in the 'hacking it for 2.6.1{6,7} department' let me know if I 
can help at all :)

BTW: Can someone tell me the version that you are changing - I may have 
a later version that fixes a problem with the V2 PCMCIA cards from 
IPWireless/T-Mobile.

    ~benm

Patrick McFarland wrote:
> On Friday 23 June 2006 09:53, Alan Cox wrote:
>> Ar Gwe, 2006-06-23 am 15:21 +0200, ysgrifennodd Charles Majola:
>>> Alan, can you please give me pointers on the tty changes since 2.6.12?
>> The newest kernels have a replacement set of tty receive functions that
>> use a new buffering system.
>>
>> http://kerneltrap.org/node/5473
>>
>> covers the changes briefly. The internals of the buffering changes are
>> quite complex because Paul did some rather neat things with SMP locking
>> but the API is nice and simple.
>>
>> Its fairly easy to express the old API in terms of the new one if you
>> are doing compat wrappers as well
> 
> Actually, its rather neat that something as 'simple' as tty still gets heavily 
> hacked on every once in awhile.
> 

