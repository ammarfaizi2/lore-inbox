Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFTQiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFTQiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFTQiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:38:19 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:61452 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261306AbVFTQhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:37:36 -0400
Message-ID: <42B6F144.10808@tmr.com>
Date: Mon, 20 Jun 2005 12:39:32 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12 udev hangs at boot
References: <200506181332.25287.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <42B697B4.8060109@stesmi.com> <200506201413.22471.vda@ilport.com.ua>
In-Reply-To: <200506201413.22471.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Monday 20 June 2005 13:17, Stefan Smietanowski wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Hi Denis.
>>
>>
>>>After all, udev is tied to /sys layout which changes with kernel
>>>and also udev is vital for properly functioning boot process
>>
>>Not if you use a static /dev.
> 
> 
> Static /dev kind of defeats the purpose of udev.

udev is a great thing is you are putting out a distribution which will 
be used on many configurations. That doesn't include most of us.

> I do not want to go back to the days when I had tons of
> /dev/{h,s}d{a,b,c,d,e,f}{0,1,2,3,4,5,6,7,8,9} for every
> IDE and SCSI block device possible. Same for /dev/tty*.
> I want them appear on the fly, if/when hardware is present.

One size doesn't fit all with that, it's nice to have hardware that the 
kernel doesn't try to use, particularly if it's hardware that the kernel 
almost but not quite knows HOW to use...

In other words, there are reasons for running static /dev, although I 
suggest trimming it to something resembling what you need.

RELATED TOPIC: It would be really nice of the changelog started with a 
"REQUIRED UPDATES" section, even though the vast majority of cases the 
description would be "none." Seeing that git didn't even provide a full 
Changelog in the previous tradition, I guess that's not likely.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
