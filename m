Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVL1SFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVL1SFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVL1SFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:05:23 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:45965 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964861AbVL1SFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:05:23 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 4k stacks
Date: Thu, 29 Dec 2005 05:05:20 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <esk5r1hear82d3l90tq3i3bfvsd8ib1ug7@4ax.com>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <200512260340.55037.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <43B1AE23.4020105@tuxrocks.com>
In-Reply-To: <43B1AE23.4020105@tuxrocks.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005 14:12:03 -0700, Frank Sorenson <frank@tuxrocks.com> wrote:

>Andrew James Wade wrote:
>> I've modified stack.c to handle 4k stacks. It can also provide information
>> for 8k stacks (fwiw) by changing STACK_GRANULARITY.
>> 
>> It found one stack with only 756 bytes left. I hope it's just due to a
>> greedy boot-time function as I'm not running anything particularly exotic.
>> (CIFS & Reiser4).
>
>Yes, it does appear to be a boot-time function.  It eventually becomes
>PID 1, and the stack usage shrinks considerably.
>

Problem I have is the stack poison patch stops box from booting when set 
to 4k stacks.  Seems to imply boot is within 5 pushl's and a return from 
4k?  Reiser3 + SATA on K7 + VIA chipset

Grant.
