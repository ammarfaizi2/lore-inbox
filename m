Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVCDFHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVCDFHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVCDFEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:04:55 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:57310 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262570AbVCDEpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:45:14 -0500
Date: Thu, 03 Mar 2005 23:45:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11 vs DVB cx88 stuffs
In-reply-to: <4227CE34.2040805@osdl.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503032345.12526.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503032119.04675.gene.heskett@verizon.net>
 <4227CE34.2040805@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 21:55, Randy.Dunlap wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> I've a new pcHDTV-3000 card, and I thought maybe it would
>> be a good idea to build the cx88 stuff in the DVB section
>> of a make xconfig.

[...]

>> This is from a freshly unpacked src tree for 2.6.11, with only the
>> bk-ieee1394 patch applied.  That doesn't touch this.
>>
>> Comments?
>>
>> Another patch needed maybe?
>
>Sure, some patch is needed.  Let's ask the maintainer (cc-ed).
>
>BTW, to get this you had to enable CONFIG_BROKEN:
>
>config VIDEO_CX88_DVB
>         tristate "DVB Support for cx2388x based TV cards"
>         depends on VIDEO_CX88 && DVB_CORE && BROKEN
>         select VIDEO_BUF_DVB

I hadn't made that connection between the CONFIG_BROKEN and that, 
Randy, so if thats the case, its of somewhat less than showstopper 
status AFAIAC.  The card is, for watching never twice same color tv, 
working just fine once the cx88** & related stuffs are replaced by 
doing a make install in the pcHDTV tree, which replaces the following 
stuff in the /lib/modules/`uname -r`/kernel/drivers dir tree:

btcx-risc.ko
bttv.ko
cx8800.ko
cx88xx.ko
tuner.ko
v4l1-compat.ko
v4l2-common.ko
video-buf.ko

At some point, it would be nice if this stuff was merged, but for the 
benefit of how many would depend on sales of this and similar hdtv 
cards.  There is of course a cost vs benefits ratio to consider in 
any such merging endeavor.  I have NDI how many users of this card 
there may be about, but suspect the user base is growing 
exponentially as 'flag day' approaches.  Jack Steven Kelliher 
<jack.kelliher@pchdtv.com> could no doubt give a better accounting.  
Sales must be good though, the last order was large enough that he 
was able to negotiate a better price than the web page shows by a $20 
bill.  He passed that savings on to us.  Thats always appreciated. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
