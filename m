Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWECRTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWECRTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWECRTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:19:19 -0400
Received: from mail.priv.de ([80.237.225.190]:37806 "EHLO mail.priv.de")
	by vger.kernel.org with ESMTP id S1030256AbWECRTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:19:18 -0400
Message-ID: <4458E619.8090501@priv.de>
Date: Wed, 03 May 2006 19:19:21 +0200
From: =?ISO-8859-1?Q?Markus_M=FCller?= <mm@priv.de>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
References: <4458C48B.8040703@priv.de> <Pine.LNX.4.61.0605031842260.13546@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605031842260.13546@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan Engelhardt,
>> Hi Linux kernel users,
>>
>> reiserfsck told me that I have to run --rebuild-tree to fix all errors. But
>> this don't work (see below), I tried two times (every time I am waiting 28
>> hours). If I mount the filesystem, there are no files in it. What can I do?
>>     
>
> Is the harddisk broken? (Check for spurious IDE warnings in /var/log/...)
> It is possible that fsck zeroed out many entries because they were not 
> readable.
>   
no, the hdd is a software raid 5, /dev/md0, which is piped through aes
via cryptsetup, so it is accessed via /dev/mapper/hdb (it is not
/dev/hdb, which you could think about the name, but /dev/md0). There
were memory problems, so the reiserfs got inconsistent. But it STILL
worked before I run reiserfsck --rebuild-tree! Just reiserfsck --check
told me to run this command, this is the only cause I run it.
>   
>> stacker:/# dmesg
>> oop0: warning: vs-5150: search_by_key: invalid format found in block 1770409.
>> Fsck?
>> ReiserFS: loop0: warning: vs-13070: reiserfs_read_locked_inode: i/o failure
>>     
> [...]
>
> reiserfs warnings, but no lowlevel warnings :-/
> Did, by chance, you use dm-flakey?
>   
Please tell me, what is dm-flakey?

Regards
Markus Mueller


