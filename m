Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWFMVQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWFMVQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWFMVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:16:22 -0400
Received: from 62-99-178-133.static.adsl-line.inode.at ([62.99.178.133]:3729
	"HELO office-m.at") by vger.kernel.org with SMTP id S932260AbWFMVQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:16:21 -0400
In-Reply-To: <Pine.LNX.4.61.0606131648390.14789@yvahk01.tjqt.qr>
References: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at> <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr> <6988083B-3A0E-41F2-A1E4-B4A953B88705@office-m.at> <Pine.LNX.4.61.0606122105490.27755@yvahk01.tjqt.qr> <2F9A5649-92B3-439A-83E4-39FC6C5B7BB7@office-m.at> <Pine.LNX.4.61.0606131648390.14789@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B264F301-A682-437B-A2EF-DBDEA97149FA@office-m.at>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Markus Biermaier <mbier@office-m.at>
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS: Cannot open root device
Date: Tue, 13 Jun 2006 23:16:18 +0200
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 13.06.2006 um 16:49 schrieb Jan Engelhardt:

>> So the result before the boot-panic is:
>>
>> ...
>> here are the partitions available:
>> 2100     500472 hde driver: ide-disk
>>  2101     500440 hde1
>> ...
>> What does this mean?
>>
> It means the partitions are there.
> Which leads us to the next question:
>  Can you mount hde1 using -t auto within your initrd shell?

What do you mean with this?
I checked it (after I found the solution in providing "root=2101" as  
kernel-cmd-string) and it failed again.
I typed: "mount -t auto /dev/hde1 /mnt".
BTW I have an "/etc/fstab" with the entry
"/dev/hde1       /mnt    ext2    defaults 1 1"

Thanks again for your tip with "printk_all_partitions" ...

Markus

