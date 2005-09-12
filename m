Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVILRkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVILRkk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVILRkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:40:40 -0400
Received: from main.gmane.org ([80.91.229.2]:56231 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750718AbVILRkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:40:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Date: Tue, 13 Sep 2005 02:34:04 +0900
Message-ID: <dg4e7t$cu4$1@sea.gmane.org>
References: <20050901212110.19192.qmail@web53605.mail.yahoo.com> <43244C33.1050502@gentoo.org> <dg1s37$kd4$1@sea.gmane.org> <dg48qi$p96$1@sea.gmane.org> <4325B1C0.80405@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <4325B1C0.80405@gentoo.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Kalin KOZHUHAROV wrote:
> 
>> Well, I did test it, but skge didn't even find the hardware :-(
>> No device was created, no dmesg output on load.
>> Instead I am running 2.6.13.1 with sk98lin-8.23.1.3.patch
>> The MB is ASUS P5GDC-V-Deluxe and the the on-board NIC:
>>
>> # lspci -v  -s 02:00.0
>> 0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 
>> 88E8053 Gigabit Ethernet Controller (rev 15)
> 
> 
> This patch was to solve an issue in skge, a driver for Marvell Yukon 
> network adapters.
> 
> Your hardware is a yukon-2 adapter, you want to use the sky2 driver from 
> the netdev tree.
Ok, that makes the things clear, thank you.

After quite a lot of fiddling iwth google and git, I found what you 
are talking about here:
http://www.mail-archive.com/netdev@vger.kernel.org/msg01592.html
http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commitdiff;h=cd28ab6a4e50a7601d22752aa7ce0c8197b10bdf

Somehow I missed it on LKML.
Unfortunately the machine with this chipset is  heavily used, so I 
am not very likely to get it off-line for testing.
Will have it in mind and try it if possible.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

