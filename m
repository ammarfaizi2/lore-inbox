Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263408AbVGATDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbVGATDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbVGATDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:03:04 -0400
Received: from alog0205.analogic.com ([208.224.220.220]:8351 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263408AbVGATC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:02:58 -0400
Date: Fri, 1 Jul 2005 15:02:11 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: christos gentsis <christos_gentsis@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
In-Reply-To: <42C585CE.1060509@yahoo.co.uk>
Message-ID: <Pine.LNX.4.61.0507011453380.4921@chaos.analogic.com>
References: <42C58203.40606@yahoo.co.uk> <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
 <42C585CE.1060509@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, christos gentsis wrote:

> Richard B. Johnson wrote:
>
>> On Fri, 1 Jul 2005, christos gentsis wrote:
>>
>>> Hello
>>>
>>> I have a friend that his Msc project is related with the development
>>> over a PCI-X card. the problem is that he do not know if the Linux
>>> kernel support the PCI-X bus. i try to find something related with the
>>> PCI-X in the kernel source but i didn't found any file or folder with a
>>> relevant name... Does any one know if PCI-X bus supported from Linux and
>>> if no how can he patch the kernel to support it...?
>>>
>>> Thanks
>>> Chris
>>
>>
>> Sure PCI-X is just PCI/66 with 64-bits. It's just like PCI/66
>> from a software standpoint.
>>
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
>>  Notice : All mail here is now cached for review by Dictator Bush.
>>                  98.36% of all statistics are fiction.
>>
> so this practically means that hi will plug the card in, install Linux
> and the card will work correctly? because normal PCI i think that is
> 32-bit... does the same driver will provide full support?
>

The driver (whatever that is), if it was written for a 64-bit
platform, can write a 64-bit word in one operation and it's
transparent. If the driver was written for a 32-bit environment,
it will still work because there is compatibility with PCI 2.x

FYI, this machine has a PCI-X bus. I have some 32-bit cards
plugged into it (SCSI controller, etc.). They work. I also
have a 64-bit card plugged into it (fiber-optic data link).
It also works, but at 133 MHz. Software never talks to it
in 'long longs' so the increased data-width isn't being used.

Warning!  Many 5-volt cards may not work on the PCI-X bus.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
