Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270847AbRHNUwx>; Tue, 14 Aug 2001 16:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270843AbRHNUwn>; Tue, 14 Aug 2001 16:52:43 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:50181 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S270841AbRHNUwc>; Tue, 14 Aug 2001 16:52:32 -0400
Date: Tue, 14 Aug 2001 13:52:35 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
cc: <hiryuu@envisiongames.net>
Subject: tmpfs works! was Large ramdisk crashes 2.4.8
Message-ID: <Pine.LNX.4.33.0108141350340.15748-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian <hiryuu@envisiongames.net> writes:

>Not that this condition should occur, but is this task something that
>could be done in tmpfs?  Does tmpfs exhibit the same problems?

I hadn't heard of tmpfs but it seems to work great.  There doesn't
seem to be much documentation on it though.  I need two ram filesystems
in my box, and no hard disk. It boots off cdrom.  So with a 128 meg
experimental box I tried the following.

swapoff -a
mount -t tmpfs -osize=35M /dev/shm1 /mnt1
mount -t tmpfs -osize=35M /dev/shm2 /mnt2
dd if=/dev/zero of=/mnt1/junk bs=1024000 count=100
dd if=/dev/zero of=/mnt2/junk bs=1024000 count=100

It seems to work but I'm a little worried about the /dev/shm1 and 2.
It doesn't seem to matter if they even exist or not, they don't seem to
do anything.  Is this just placeholder candy for fstab and the mount
command, or am I missing something?




>	-- Brian

>On Saturday 11 August 2001 04:10 pm, Paul Buder wrote:
>> A large ramdisk will either crash or make useless a
>> 2.4.8 kernel.  I did the following.
>>
>> I cleared out buffered memory by running this till it
>> appropiately died.
>> perl -e "$x='x' x 10000 while 1"
>>
>> top then said I was using 7 megs of ram on my 128 meg box.


