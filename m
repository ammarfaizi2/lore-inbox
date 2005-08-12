Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVHLIEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVHLIEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHLIEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:04:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53418 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750783AbVHLIEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:04:04 -0400
Message-ID: <42FC57EC.2060204@pobox.com>
Date: Fri, 12 Aug 2005 04:03:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Jackman <sjackman@gmail.com>
CC: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
References: <7f45d939050809163136a234a@mail.gmail.com>	 <42FC0DD4.9060905@gmail.com> <7f45d93905081201001a51d51b@mail.gmail.com>
In-Reply-To: <7f45d93905081201001a51d51b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Jackman wrote:
> 2005/8/11, Tejun Heo <htejun@gmail.com>:
> 
>>Shaun Jackman wrote:
>>
>>>I added a PCI SATA controller to my computer. Immediately after grub
>>>loads the kernel there is a consistent ten minute delay before the
>>>kernel displays its first message. I tested Linux 2.6.8 and 2.6.11
>>>both from Debian, and 2.6.11 from Knoppix, all of which experience the
>>>same delay.
>>
>>  * What do you mean by the `first' message?  ie. What's the first line
>>you read?
>>  * Is it really ten minutes?
> 
> 
> Hello, Tejun. Thanks for the reply.
> 
> The message displayed by the bootloader, grub, is...
> root (hd2,2)
> 	Filesystem type is ext2fs, partition type 0x83
> kernel /boot/vmlinuz-2.6.11-1-k7 root=/dev/md0 ro nodma
> 	[Linux-bzImage, setup=0x1600, size=0x122a667]
> initrd /boot/initrd.img-2.6.11-1-1-k7
> 	[Linux-initrd @ 0x1fb29000, 0x4c6000 bytes]
> boot
> 
> At this point there is a nine minute, fifteen second delay. As soon as
> the kernel starts printing messages it goes by quite fast, so I can't
> be certain what it's printing, but the first message according to
> dmesg is...
> Linux version 2.6.11-1-k7 (dannf@firetheft) (gcc version 3.3.6 (Debian 1:3.3.6-6
> )) #1 Mon Jun 20 21:26:23 MDT 2005
> BIOS-provided physical RAM map:

It's doing something BIOS-related at that point.

Try booting with 'edd=off' or disabling CONFIG_EDD.

	Jeff



