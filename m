Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUIILxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUIILxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUIILxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:53:23 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:29361 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S269437AbUIILxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:53:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: another oops, this time in 2.6.9-rc1-mm4
Date: Thu, 9 Sep 2004 07:53:10 -0400
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <200409090107.05415.gene.heskett@verizon.net> <20040909063843.GB8352@kroah.com>
In-Reply-To: <20040909063843.GB8352@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409090753.10177.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.49.110] at Thu, 9 Sep 2004 06:53:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 02:38, Greg KH wrote:
>On Thu, Sep 09, 2004 at 01:07:05AM -0400, Gene Heskett wrote:
>> Greetings;
>>
>> I just had to reboot back to -mm2 after playing with some printer
>> configs in cups, although the test pages worked, so I'm not sure
>> what this all about, from var log/messages:
>>
>> Sep  8 23:13:42 coyote cups: cupsd -HUP succeeded
>> Sep  8 23:13:43 coyote kernel: usb_unlink_urb() is deprecated for
>> synchronous unlinks.  Use usb_kill_urb() Sep  8 23:13:43 coyote
>> kernel: Badness in usb_unlink_urb at drivers/usb/core/urb.c:456
>> Sep  8 23:13:44 coyote kernel:  [<c01048ce>] dump_stack+0x1e/0x20
>> Sep  8 23:13:44 coyote kernel:  [<c0295f35>]
>> usb_unlink_urb+0x85/0xa0 Sep  8 23:13:44 coyote kernel: 
>> [<c02a7447>] usblp_unlink_urbs+0x17/0x40 Sep  8 23:13:44 coyote
>> kernel:  [<c02a74a8>] usblp_release+0x38/0x60 Sep  8 23:13:44
>> coyote kernel:  [<c01501ea>] __fput+0x12a/0x140 Sep  8 23:13:44
>> coyote kernel:  [<c014e8e7>] filp_close+0x57/0x80 Sep  8 23:13:44
>> coyote kernel:  [<c014e971>] sys_close+0x61/0x90 Sep  8 23:13:44
>> coyote kernel:  [<c010425d>] sysenter_past_esp+0x52/0x71
>>
>> repeat about 40-50 times before I rebooted cause it was very
>> sluggish.
>
>It's not a oops, it's a message that the driver needs to be fixed
> up, and can be ignored safely (but sending a patch to fix the
> driver would be even nicer...)
>
No doubt Greg, if I had a clue about usb things.  Oops or not, that 
reboot took 20x as long as it should have in the shutdown as 
something was seriously eating cpu.  I went to another shell to see 
if top would run, but 2 minutes after I'd typed it, still no top.  
Hence the reboot to -mm2, which has been stable although no optical 
(dvd/cd) recordings have been attempted.

Another question, has anything been done recently that would disable 
amanda?

>thanks,
>
>greg k-h

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.25% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
