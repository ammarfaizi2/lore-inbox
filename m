Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318090AbSGRNwQ>; Thu, 18 Jul 2002 09:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318089AbSGRNwQ>; Thu, 18 Jul 2002 09:52:16 -0400
Received: from [210.78.134.243] ([210.78.134.243]:32260 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S318087AbSGRNwQ>;
	Thu, 18 Jul 2002 09:52:16 -0400
Date: Thu, 18 Jul 2002 21:57:18 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: problem of linux-2.4.19
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207182159820.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i   replaced 'read-only' in lilo with 'read-write'. and it worked. the system worked well.
but why it worked int pre1 and pre2,but not in rc1 and rc2, is there some modification to this in the kernel?
thanks.


>At 15:02 18-7-02, you wrote:
>
>>   i met some problem with linux2.4.19. i devided my disk to three 
>> partitions: hda1,hda2 and hda3.  hda3 is the swap. both hda1 and hda2 are 
>> ext3 file system. i boot the system with a initrd image which is saved on hda1.
>>   when i use linux-2.4.19-pre1 and pre2, the system worked well. but when 
>> i test linux-2.4.19-pre9,pre10,rc1 and rc2, the same problem happened to 
>> all these verions. the system boot up, but the filesystem is readonly.the 
>> following is what on the screen(not exactly):
>>..
>>mount root as readonly
>>INIT version is 2.78
>>swap on(swap priority -1)
>>..
>
>this looks like normal behaviour (output from dmesg):
><snip>
>VFS: Mounted root (reiserfs filesystem) readonly.
><snip>
>
>>   is there some bugs in linux-2.4.19 with the filesystem? or with the 
>> initrd boot? or i made some mistakes?
>
>the last 2 lines of your output are NOT kernel messages, when you see 'INIT 
>version ...' it means that the kernel has booted and userspace bootup begins.
>
>your bootscripts should first check the root filesystem (and then it must 
>be mounted readonly) and then remount it read/write
>
>another possiblity is to change your lilo.conf and remove the line which 
>says 'read-only' or replace it with 'read-write'
>
>if you do not have lilo, then check the man-page of your bootloader on how 
>to force the kernel to mount root rw
>
>         Rudmer



