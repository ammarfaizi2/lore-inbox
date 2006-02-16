Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWBPHst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWBPHst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWBPHst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:48:49 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:56470 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932508AbWBPHss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:48:48 -0500
Message-ID: <43F42DFC.4080604@aitel.hist.no>
Date: Thu, 16 Feb 2006 08:47:08 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: fsck: i_blocks is xxx should be yyy on ext3
References: <43EA079A.4010108@aitel.hist.no>	 <20060208225359.426573cf.akpm@osdl.org> <1140050679.20936.14.camel@dyn9047017067.beaverton.ibm.com>
In-Reply-To: <1140050679.20936.14.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:

>On Wed, 2006-02-08 at 22:53 -0800, Andrew Morton wrote:
>  
>
>>Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>>    
>>
>>> Today I rebooted into 2.6.16-rc2-mm1.  Fsck checked a "clean" ext3 fs,
>>> because it was many mounts since the last time.
>>>
>>> I have seen that many times, but this time I got a lot of
>>> "i_blocks is xxx, should be yyy fix?"
>>>
>>> In all cases, the blocks were fixed to a lower number.
>>>      
>>>
>>Yes, thanks.  It's due to the ext3_getblocks() patches in -mm.  I can't
>>think of any actual harm which it'll cause.
>>
>>To reproduce:
>>
>>mkfs
>>mount
>>dbench 32
>><wait 20 seconds>
>>killall dbench
>>umount
>>fsck
>>-
>>    
>>
>
>Sorry about the late response.  I failed to reproduce the problem with
>above instructions. I am running 2.6.16-rc2-mm1 kernel, played dbench
>32 ,64 and 128, and tried both 8 cpu and 1 cpu, still no luck at last. I
>am using e2fsck version 1.35 though. What versions you are using?
>  
>
single cpu, e2fsck 1.39-WIP (31-Dec-2005)
        Using EXT2FS Library version 1.39-WIP, 31-Dec-2005

I didn't use dbench, only normal use of the machine.

Helge Hafting

