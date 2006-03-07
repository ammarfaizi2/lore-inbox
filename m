Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWCGMZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWCGMZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWCGMZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:25:33 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:37905 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S1750858AbWCGMZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:25:32 -0500
X-Obalka-From: mmokrejs@ribosome.natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Message-ID: <440D7BB8.40106@ribosome.natur.cuni.cz>
Date: Tue, 07 Mar 2006 13:25:28 +0100
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 huge memory detection regression
References: <440D6581.9080000@ribosome.natur.cuni.cz> <20060307041532.3ef45392.akpm@osdl.org>
In-Reply-To: <20060307041532.3ef45392.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
> 
>>  I just tested 2.6.16-rc5 kernel on MSI 9136 dual Xeon server 
>> motherboard with 16 GB of memory and the kernel detects only 8 GB of 
>> RAM instead. 2.6.15 kernel detected properly 16 GB. I haven't tested 
>> any kernel revisions in between these two, but could if you point me 
>> in a specific direction. Attaching diff(1) output of dmesg(1) outputs.
>> Please Cc: me in replies. Thanks!
>> Martin
>>
>>
>>[boot-2.6.15_to_16-rc5.diff  text/plain (12156 bytes)]
> 
> 
> The diff is useful.
> 
> 
>> --- tmp/boot-2.6.15.txt	2006-03-07 11:45:48.015509048 +0100
>> +++ tmp/boot-2.6.16-rc5.txt	2006-03-07 11:45:48.029506920 +0100
>> @@ -1,4 +1,4 @@
>> -Linux version 2.6.15 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 20:20:06 MET 2006
>> +Linux version 2.6.16-rc5 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 19:58:24 MET 2006
>>  BIOS-provided physical RAM map:
>>   BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
>>   BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
>> @@ -12,16 +12,16 @@
>>   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>>   BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
>>   BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
>> - BIOS-e820: 0000000100000000 - 0000000430000000 (usable)
>> -16256MB HIGHMEM available.
>> + BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
>> +8064MB HIGHMEM available.
> 
> 
> These numbers are what the BIOS is telling the kernel about your machine. 
> Was the BIOS changed?

No, it hasn't since we got the motherboard. Yes, it is 1.20 instead 
of 1.50. The MSI web is such a crap I couldn't first of all get the 
file at all and once found on a local reseller's page the zip file 
contains no Changelog, so I have no clue what happened between 1.20 
and 1.50 BIOS revision.

> 
> If not, you might need to wiggle those DIMMs or something.

It is really something else, 16GB can be seen under 2.6.15, 
2.6.15-rc1 (if I remember right my previous kernel version).
I can reproduce just by booting with "wrong" kernel version.
Any other recommendation? Except flashing and praying?
I haven't touched the BIOS setting either, I worked completely remotely.

Martin
