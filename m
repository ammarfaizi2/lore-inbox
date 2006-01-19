Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbWASNS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWASNS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWASNSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:18:25 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:22947 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1161162AbWASNSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:18:25 -0500
X-Sasl-enc: jTcm3/kpQdJexGV/ASj7QvOVIH6P4QGbgPrflpzKSZ1q 1137676703
Message-ID: <43CF919B.1020902@fastmail.co.uk>
Date: Thu, 19 Jan 2006 21:18:19 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060117)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <20060119004853.GP19398@stusta.de>
In-Reply-To: <20060119004853.GP19398@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, they don't want me to spend time doing this sort of 
thing, so I'm out of luck.

They're going to stick with 2.6.8-smp, which seems to give the best 
performance (which rules out your second case below, I suppose).

:|

Max.

Adrian Bunk wrote:
> On Mon, Jan 16, 2006 at 03:35:31PM +0800, Max Waterman wrote:
>> Hi,
>>
>> I've been referred to this list from the linux-raid list.
>>
>> I've been playing with a RAID system, trying to obtain best bandwidth
>> from it.
>>
>> I've noticed that I consistently get better (read) numbers from kernel 2.6.8
>> than from later kernels.
>>
>> For example, I get 135MB/s on 2.6.8, but I typically get ~90MB/s on later
>> kernels.
>>
>> I'm using this :
>>
>> <http://www.sharcnet.ca/~hahn/iorate.c>
>>
>> to measure the iorate. I'm using the debian distribution. The h/w is a 
>> MegaRAID
>> 320-2. The array I'm measuring is a RAID0 of 4 Fujitsu Max3073NC 15Krpm 
>> drives.
>>
>> The later kernels I've been using are :
>>
>> 2.6.12-1-686-smp
>> 2.6.14-2-686-smp
>> 2.6.15-1-686-smp
>>
>> The kernel which gives us the best results is :
>>
>> 2.6.8-2-386
>>
>> (note that it's not an smp kernel)
>>
>> I'm testing on an otherwise idle system.
>>
>> Any ideas to why this might be? Any other advice/help?
> 
> You should try to narrow the problem a bit down.
> 
> Possible causes are:
> - kernel regression between 2.6.8 and 2.6.12
> - SMP <-> !SMP support
> - patches and/or configuration changes in the Debian kernels
> 
> You should try self-compiled unmodified 2.6.8 and 2.6.12 ftp.kernel.org 
> kernels with the same .config (modulo differences by "make oldconfig").
> 
> After this test, you know whether you are in the first case.
> If yes, you could do a bisect search for finding the point where the 
> regression started.
> 
>> Thanks!
>>
>> Max.
> 
> cu
> Adrian
> 

