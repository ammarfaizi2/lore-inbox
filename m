Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVILQGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVILQGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVILQGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:06:33 -0400
Received: from main.gmane.org ([80.91.229.2]:61838 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750870AbVILQGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:06:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Date: Tue, 13 Sep 2005 01:01:39 +0900
Message-ID: <dg48qi$p96$1@sea.gmane.org>
References: <20050901212110.19192.qmail@web53605.mail.yahoo.com> <43244C33.1050502@gentoo.org> <dg1s37$kd4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <dg1s37$kd4$1@sea.gmane.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Daniel Drake wrote:
> 
>> Hi,
>> 
>> Steve Kieu wrote:
>> 
>>> If run 2.6.13 and up the NIC, it is working. Shuttdown or 
>>> reboot using /sbin/halt (means power completely off and on) 
>>> or /sbin/reboot all other OSs failed to enable the NIC except
>>>  2.6.13.
>>> 
>>> to restore the normal working of the NIC, boot 2.6.13 and do 
>>> a hot power reset. (press the reset button)
>> 
>> 
>> 
>> Stephen recently posted a patch which looks like it might solve
>>  this issue.
>> 
>> Steve, maybe you could test it out? I have attached it to this 
>> Gentoo bug:
>> 
>> http://bugs.gentoo.org/100258
>> 
>> Stephen, thanks for your hard work!
> 
> 
> I will try this one on a problematic ASUS board than now runs on 
> 2.11.11 with sk98lin-8.18.2.2.patch.
> 
> Applied the patch from #100258 to 2.6.13.1 successfully (some
> lines offset) and recompiled. Will try it tomorrow when I am at
> the machine.

Well, I did test it, but skge didn't even find the hardware :-(
No device was created, no dmesg output on load.
Instead I am running 2.6.13.1 with sk98lin-8.23.1.3.patch
The MB is ASUS P5GDC-V-Deluxe and the the on-board NIC:

# lspci -v  -s 02:00.0
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 
88E8053 Gigabit Ethernet Controller (rev 15)
         Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit 
Ethernet Controller (Asus)
         Flags: bus master, fast devsel, latency 0, IRQ 17
         Memory at cfffc000 (64-bit, non-prefetchable) [size=16K]
         I/O ports at d800 [size=256]
         Expansion ROM at cffc0000 [disabled] [size=128K]
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data
         Capabilities: [5c] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
         Capabilities: [e0] #10 [0011]


I am not sure it is supposed to be used with the skge driver, but I
thought it will work... Some ASUS boards apparently have problems 
with the VPD being broken, but I am not sure how to check that.

> BTW, is this patch submitted to the Linus or -mm tree already?
??

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

