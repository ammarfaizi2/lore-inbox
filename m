Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271161AbTG1Wqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271159AbTG1Wqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:46:51 -0400
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:37772 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id S271161AbTG1Wqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:46:50 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: Re: 2.6.0-test2 - VFS: Cannot open root device "NULL" or sda1
Date: Mon, 28 Jul 2003 22:46:48 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <bg494o$ar5$1@ask.hswn.dk>
References: <bg1df5$1c2$1@ask.hswn.dk> <20030728022818.GA7221@yahoo.com> <20030728022818.GA7221@yahoo.com> <3F24A548.2040202@rogers.com>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: ask.hswn.dk 1059432408 11109 172.16.10.100 (28 Jul 2003 22:46:48 GMT)
X-Complaints-To: news@ask.hswn.dk
NNTP-Posting-Date: Mon, 28 Jul 2003 22:46:48 +0000 (UTC)
User-Agent: nn/6.6.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <3F24A548.2040202@rogers.com> gaxt <gaxt@rogers.com> writes:

>Yifang Dai wrote:
>> On Sun, Jul 27, 2003 at 08:42:13PM +0000, Henrik Storner wrote:
>> 
>>>So I know 2.6.0-test1 works for me. But 2.6.0-test2 with the same
>>>configuration (just a "make oldconfig" in between) stops during boot
>>>with:
>>>
>>>VFS: Cannot open root device "NULL" or sda1
>>
>> I've got the same error, except my root device is /dev/hda3. It also
>> worked in 2.6.0-test1 :)

>I believe you need to change in your grub.conf file the root=/dev/hda3 
>to a root=### ie root=0307

Doesn't seem to do much good here. I've tried:

root=/dev/sda1
root=0801
root=801
root=2049         (0801 hex = 2049 decimal)
root=08:01
root=/dev/sda/1

but none of them gets the kernel to mount the root fs (yes, I do
have the SCSI driver and my reiserfs filesystem compiled in).

Anyone who added patches to -test2 who have a clue about what
is going on ?


Henrik
-- 
Henrik Storner <henrik@hswn.dk> 
