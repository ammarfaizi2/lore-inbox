Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTFCWfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTFCWfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:35:20 -0400
Received: from post-21.mail.nl.demon.net ([194.159.73.20]:62470 "EHLO
	post-21.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S261624AbTFCWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:35:18 -0400
Message-ID: <3EDD25A0.1040602@maatwerk.net>
Date: Wed, 04 Jun 2003 00:48:00 +0200
From: Mauk van der Laan <mauk.lists@maatwerk.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: siimage slow on 2.4.21-rc6-ac2
References: <3EDD1C87.5090906@maatwerk.net> <1054675355.9233.73.camel@dhcp22.swansea.linux.org.uk> <3EDD2260.20200@maatwerk.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He! I just did

# hdparm -d1 -X66 /dev/hdX
# echo "max_kb_per_request:15" > /proc/.ide/hdX/settings

on BOTH sata drives and everything works fine!
Is it possible that they influence each other?

Mauk

Mauk van der Laan wrote:

> Alan Cox wrote:
>
>> On Maw, 2003-06-03 at 23:09, Mauk van der Laan wrote:
>>  
>>
>>> I just tested the siimage driver in 2.4.21-rc6-ac2. The errors i get 
>>> in -rc6 have disappeared but
>>> the computer becomes unresponsive (20 seconds between screen 
>>> switches) when I run bonnie
>>> and the disk is very slow:
>>>   
>>
>>
>> Sounds like your system has switched back to PIO.
>>
>>  
>>
> Yes, it did. Nothing in the log, though.
>
> Still having problems:
> hdparm -d1 -X66 /dev/hdg
> mke2fs /dev/hdg1
>
> See the empty lines and the funny r 18 line?
>
> Jun  4 00:28:56 debby kernel: blk: queue c0407c34, I/O limit 4095Mb 
> (mask 0xffffffff)
> Jun  4 00:29:42 debby kernel: hdg: dma_timer_expiry: dma status == 0x21
> Jun  4 00:29:52 debby kernel: hdg: dma timeout retry: status=0xd8 { 
> Busy }
> Jun  4 00:29:52 debby kernel:
> Jun  4 00:29:52 debby kernel: hdg: DMA disabled
> Jun  4 00:29:52 debby kernel: ide3: reset phy, status=0x00000113, 
> siimage_reset
> Jun  4 00:30:22 debby kernel: ide3: reset timed-out, status=0xd8
> Jun  4 00:30:22 debby kernel: hdg: status timeout: status=0xd8 { Busy }
> Jun  4 00:30:22 debby kernel:
> Jun  4 00:30:22 debby kernel: ide3: reset phy, status=0x00000113, 
> siimage_reset
> Jun  4 00:30:52 debby kernel: r 18
> Jun  4 00:30:52 debby kernel: end_request: I/O error, dev 22:01 (hdg), 
> sector 20
> Jun  4 00:30:52 debby kernel: end_request: I/O error, dev 22:01 (hdg), 
> sector 22
> Jun  4 00:30:52 debby kernel: end_request: I/O error, dev 22:01 (hdg), 
> sector 4088
> Jun  4 00:30:52 debby kernel: end_request: I/O error, dev 22:01 (hdg), 
> sector 4090
> (lots more of these)
>
> Mauk
>


