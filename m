Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRIHKqY>; Sat, 8 Sep 2001 06:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRIHKqE>; Sat, 8 Sep 2001 06:46:04 -0400
Received: from imo-d08.mx.aol.com ([205.188.157.40]:14758 "EHLO
	imo-d08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S268934AbRIHKqC>; Sat, 8 Sep 2001 06:46:02 -0400
From: Floydsmith@aol.com
Message-ID: <51.10cc64a8.28cb50f8@aol.com>
Date: Sat, 8 Sep 2001 06:46:16 EDT
Subject: Re2: LOADLIN and 2.4 kernels
To: tegeran@home.com, linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Hi everyone,
>> >
>> >I got a bug report of LOADLIN not working with recent -ac kernels, and
>> >thought it might have something to do with my recent A20 changes that
>> >were added to -ac.  However, in trying to reproduce this bug, I have
>> >been completely unable to boot *any* 2.4 kernel with LOADLIN-1.6,
>> > trying this from Win98 DOS mode.
>> >
>> >Anyone have any insight into this?  I really don't understand how the
>> >A20 changes could affect LOADLIN, and it's starting to look to me that
>> >there is some other problem going on...
>> >
>> >        -hpa
>>
>
><snip>
>
>> loads the 2.4.x kernel into a buffer. The kernel then attempts boot
>> just the "boot" sector stuff. This again probes for the total amount of
>> system ram (64MB). But, because of the much greater size of 2.4.x
>> kernels some memory location that himem uses (I think - maybe BIOS

>Sounds like something booting to Safe Mode Command Prompt Only would fix, 
>as opposed to booting to plain command prompt mode
>command prompt mode will load some drivers (such as himem), better not to 
>load them when using LOADLIN. Safe Mode Command Prompt Only boots 
>straight to the command prompt, very similar to setting init to /bin/sh 
>for a completely bare single-user mode.


Yes, indeed, not loading himem does solve the problem I had. But, do to the 
fact that I need extented memory (for a DOS ramdisk) and for some TSR(s) 
(like smartdrv) for a LS-120 boot disk I use as both a Linux and DOS "rescue" 
disk, I need "himem".

Floyd,
