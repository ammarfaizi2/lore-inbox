Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUDSPCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbUDSPCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:02:03 -0400
Received: from bay14-f33.bay14.hotmail.com ([64.4.49.33]:29700 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264494AbUDSPBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:01:43 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [qwejohn@hotmail.com]
From: "John Que" <qwejohn@hotmail.com>
To: bart@samwel.tk
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC inerrupt
Date: Mon, 19 Apr 2004 18:01:42 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F33hoh8qR3dCy0005f5b8@hotmail.com>
X-OriginalArrivalTime: 19 Apr 2004 15:01:42.0584 (UTC) FILETIME=[399FEB80:01C4261F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
thnxs;
You are right in that I send about 4500-5000 packets in a second.
I will try to print it every 1000  packets and see.
john


>From: Bart Samwel <bart@samwel.tk>
>To: John Que <qwejohn@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: NIC inerrupt
>Date: Mon, 19 Apr 2004 16:40:08 +0200
>
>
>
>John Que wrote:
>>Hello,
>>
>>I want to count the number of times I reach an NIC receive
>>interrupt.
>>
>>I added a global static variable of type int , and initialized
>>it to 0 ; each time I am in the rx_interrupt of the card I incerement
>>it by one;
>>I got large , non sensible numbers after one or two seconds;
>>
>>So  for debug I added printk each time I increment it in rx_interrupt.
>>
>>What I see is that there are  unreasonable jumps in the number
>>
>>for instance , it inceremnts sequntially from 1 to 80,then jums to 4500, 
>>increments a little sequentially to 4580, and the jums again to
>>11000 ;
>>
>>Is it got to do with it that this is in interrupt?
>>Any idea what it can be ?
>
>You're probably reading the kernel output from syslog. Syslog periodically 
>reads out the printks from the kernel. With the amount of printks you're 
>doing you are probably printing info for about 4500 interrupts between 
>every time syslog checks for new kernel output, while the kernel buffer 
>that is used to store this information can only handle   enough data for 80 
>interrupts.
>
>--Bart

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

