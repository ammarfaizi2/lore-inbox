Return-Path: <linux-kernel-owner+w=401wt.eu-S1751845AbXAVOmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbXAVOmS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXAVOmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:42:18 -0500
Received: from xylophone.i-cable.com ([203.83.115.99]:43894 "HELO
	xylophone.i-cable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751845AbXAVOmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:42:17 -0500
Message-ID: <005501c73e33$7d9046d0$28df0f3d@kylecea1512a3f>
From: "kyle" <kylewong@southa.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f> <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan>
Subject: Re: change strip_cache_size freeze the whole raid
Date: Mon, 22 Jan 2007 21:09:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Mon, 22 Jan 2007, kyle wrote:
>
>> Hi,
>>
>> Yesterday I tried to increase the value of strip_cache_size to see if I 
>> can
>> get better performance or not. I increase the value from 2048 to 
>> something
>> like 16384. After I did that, the raid5 freeze. Any proccess read / write 
>> to
>> it stucked at D state. I tried to change it back to 2048, read
>> strip_cache_active, cat /proc/mdstat, mdadm stop, etc. All didn't return 
>> back.
>> I even cannot shutdown the machine. Finally I need to press the reset 
>> button
>> in order to get back my control.

> Yes, I noticed this bug too, if you change it too many times or change it
> at the 'wrong' time, it hangs up when you echo numbr >
> /proc/stripe_cache_size.
>
> Basically don't run it more than once and don't run it at the 'wrong' time
> and it works.  Not sure where the bug lies, but yeah I've seen that on 3
> different machines!
>
> Justin.
>
>

I just change it once, then it freeze. It's hard to get the 'right time'

Actually I tried it several times before. As I remember there was once it 
freezed for around 1 or 2 minutes , then back to normal operation. This is 
the first time it completely freezed and I waited after around 10 minutes it 
still didn't wake up.

Kyle

