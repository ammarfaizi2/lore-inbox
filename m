Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWINIgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWINIgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWINIgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:36:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:15412 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751467AbWINIgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:36:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VrMwdlEzZPHIexETEBRJw5lcXlRnlb6HZ3lqwWfwW6RL3lSZqnqRf+nGgW3yZ29cSip3X2iSJ80Khz44zeWGm8eB0wwljkrm2MjFtI0TKC9b/fDlzUxlVHicjlXwKjFWnsnqw9FQM0vnJ7Nq3I8cOvA0u6ZHjw1hsw0hTuupYr8=
Message-ID: <450914C4.2080607@gmail.com>
Date: Thu, 14 Sep 2006 10:37:24 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com> <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com> <20060912162555.d71af631.akpm@osdl.org> <6bffcb0e0609121634l7db1808cwa33601a6628ee7eb@mail.gmail.com> <20060912163749.27c1e0db.akpm@osdl.org> <20060913015850.GB3034@melbourne.sgi.com> <20060913042627.GE3024@melbourne.sgi.com> <6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com> <20060914035904.GF3034@melbourne.sgi.com>
In-Reply-To: <20060914035904.GF3034@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:
> On Wed, Sep 13, 2006 at 11:43:32AM +0200, Michal Piotrowski wrote:
>> On 13/09/06, David Chinner <dgc@sgi.com> wrote:
>>> I've booted 2.6.18-rc6-mm2 and mounted and unmounted several xfs
>>> filesystems. I'm currently running xfsqa on it, and I haven't seen
>>> any failures on unmount yet.
>>>
>>> That test case would be really handy, Michal.
>> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/test_mount_fs.sh
>>
>> ls -hs /home/fs-farm/
>> total 3.6G
>> 513M ext2.img  513M ext4.img  513M reiser3.img  513M xfs.img
>> 513M ext3.img  513M jfs.img   513M reiser4.img
> 
> Ok, so you're using loopback and mounting one of each filesystem, then
> unmounting them in the same order. I have mounted and unmounted an
> XFS filesystem in isolation in exactly the same way you have been, but
> I haven't seen any failures.
> 
> Can you rerun the test with just XFS in your script and see if you
> see any failures? If you don't see any failures, can you add each
> filesystem back in one at a time until you see failures again?


I still get an oops (with xfs only). Maybe it's file system image problem.

xfs_info /mnt/fs-farm/xfs/
meta-data=/dev/loop1             isize=256    agcount=8, agsize=16384 blks
         =                       sectsz=512
data     =                       bsize=4096   blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=1200, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

> 
> Cheers,
> 
> Dave.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
