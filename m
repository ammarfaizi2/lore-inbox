Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbWFASwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbWFASwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWFASwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:52:10 -0400
Received: from mx5.redainternet.nl ([82.98.244.137]:57611 "EHLO
	mx5.redainternet.nl") by vger.kernel.org with ESMTP id S965259AbWFASwJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:52:09 -0400
Message-ID: <447F3755.30405@inn.nl>
Date: Thu, 01 Jun 2006 20:52:05 +0200
From: Arend Freije <afreije@inn.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.1) Gecko/20060418 SeaMonkey/1.0
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: RAID-1 and Reiser4 issue: umount hangs
References: <4478CF33.80609@inn.nl> <17528.55008.287088.705263@cse.unsw.edu.au> <44797136.4050707@inn.nl> <17530.14115.195147.46212@cse.unsw.edu.au> <447D5F7C.8020401@inn.nl> <20060531093644.GL29535@suse.de>
In-Reply-To: <20060531093644.GL29535@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, May 31 2006, Arend Freije wrote:
>   
>> You're probably right. I found several posts on the linux-kernel list
>> involving problems with write barrier support in combination with SATA
>> and ext3 . So I tried:
>>
>> # mkfs -t ext3 /dev/md/0
>> # mount -o barrier=1 /dev/md/0 /mnt
>> # cp -a $src /mnt
>> # umount /mnt
>>
>> And indeed, umount hangs now as well.
>> So it seems to be a linux-kernel issue after all...
>>     
>
> Can you please try 2.6.17-rc5?
>
>   

Great! 2.6.17_rc5 fixed this is issue. For Reiser4 as well as Ext3 (with
barrier=1).

Many Thanks!

Arend
