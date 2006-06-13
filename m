Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWFMVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWFMVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFMVd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:33:29 -0400
Received: from 62-99-178-133.static.adsl-line.inode.at ([62.99.178.133]:5777
	"HELO office-m.at") by vger.kernel.org with SMTP id S932240AbWFMVd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:33:29 -0400
In-Reply-To: <20060613142229.5072b657.rdunlap@xenotime.net>
References: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at> <20060613142229.5072b657.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1A2AB079-32AC-40F2-AFB4-422A9FF2E86B@office-m.at>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Markus Biermaier <mbier@office-m.at>
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS: Cannot open root device
Date: Tue, 13 Jun 2006 23:33:26 +0200
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 13.06.2006 um 23:22 schrieb Randy.Dunlap:

> On Tue, 13 Jun 2006 23:10:04 +0200 Markus Biermaier wrote:
>>> So the result before the boot-panic is:
>>>
>>> ...
>>> here are the partitions available:
>>> 2100     500472 hde driver: ide-disk
>>>   2101     500440 hde1
>>> ...

[snip]

>> But can anyone tell me how "root=/dev/hde1" translates to  
>> "root=2101"???
>
> That's (hex) 0x2101.  In Documentation /devices.txt, we see:
>
>  33 block	Third IDE hard disk/CD-ROM interface
> 		  0 = /dev/hde		Master: whole disk (or CD-ROM)
> 		 64 = /dev/hdf		Slave: whole disk (or CD-ROM)
>
> 		Partitions are handled the same way as for the first
> 		interface (see major number 3)
>
> So device 33 (hex 21) is /dev/hde and 0x01 is partition 1 == hde1.

Aaargh:
Its HEX and I tried always in my "linuxrc":
------------------------- [ BEGIN linuxrc ] -------------------------
...
# brw-rw----    1 root     disk      33,   1 Jan 19  2001 /dev/hde1
echo 0x3301 > /proc/sys/kernel/real-root-dev
...
------------------------- [ END   linuxrc ] -------------------------
So it would have probably worked if I would have written "echo  
0x2101 ..."

Thank you, Randy.

Markus

