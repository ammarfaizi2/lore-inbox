Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTLPVui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTLPVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:50:38 -0500
Received: from s383.jpl.nasa.gov ([137.79.94.127]:33991 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S262838AbTLPVua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:50:30 -0500
Message-ID: <3FDF7E1C.9040807@jpl.nasa.gov>
Date: Tue, 16 Dec 2003 13:50:20 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw, ja
MIME-Version: 1.0
To: Bryan Whitehead <driver@jpl.nasa.gov>
CC: "Stephen C. Tweedie" <sct@redhat.com>, tsuchiya@labs.fujitsu.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com> <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>
In-Reply-To: <3FDF7BE0.205@jpl.nasa.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, this happens on these filesystems we tried: ext2, ext3, and XFS.

Bryan Whitehead wrote:
> I get this problem all the time here at JPL. I can always get the files 
> back by remounting the filesystem.
> 
> For example if /dev/sdb1 mounted on /export/project is getting wierd 
> "Input/output" errors I can simply run this command:
> mount -o remount /dev/sdb1 /export/project
> 
> It's been about a year of these problems... I'll try running the test 
> Tsuchiya Yoshihiro made to reproduce. (I have not been able to create a 
> test that can consistantly reproduce... but the problem has sure screwed 
> up some data-gathering runs in the lab).
> 
> These are all on Mandrake kernels though.... (from the 9.0 series). so 
> that's 2.4.19+tonOfPatches.
> 
> Stephen C. Tweedie wrote:
> 
>> Hi,
>>
>> On Mon, 2003-12-15 at 09:25, Tsuchiya Yoshihiro wrote:
>>
>>
>>> Following is an Ext2 result and the inode is filled by zero.
>>> I think the inode becomes a badinode.
>>
>>
>>
>>> [root@dell04 tsuchiya]# ls -l 
>>> /mnt/foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html
>>> ls: 
>>> /mnt/foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html: 
>>> Input/output error
>>
>>
>>
>> "Input/output error" can sometimes mean that the kernel has found a
>> filesystem problem, but it also often indicates a device-layer 
>> problem. Is there anything helpful in the kernel logs?
>>
>> Cheers,
>>  Stephen
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry and Large Optical Systems
Phone: 818 354 2903
driver@jpl.nasa.gov

