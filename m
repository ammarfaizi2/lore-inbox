Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUIMP3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUIMP3j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUIMP3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:29:30 -0400
Received: from [64.65.177.98] ([64.65.177.98]:51632 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S267576AbUIMPVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:21:20 -0400
Message-ID: <4145BAE9.1040800@pacrimopen.com>
Date: Mon, 13 Sep 2004 08:21:13 -0700
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040824)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: jch@imr-net.com, ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com> <41451957.7000101@kolivas.org>
In-Reply-To: <41451957.7000101@kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,


    I did not mention before, I thought it was a fluke on my system. Now 
its affecting two systems since applying ck7.


<snip>
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
DataRequest }ide: failed opcode was 100
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
DataRequest }ide: failed opcode was 100
hda: CHECK for good STATUS
<snip>

That is happening while applying the dma settings to the hard drive.

In both cases, the drive is a Western Digital 40GB hard drive.  That is 
the only solid commoniality.  One is a P4 2.8, the other a P4 2.4.   
Intel Chipset + Intel IDE in one, Intel Chipset + HighPoint chipset in 
the other. 

However, the code is exactly the same.


Thanks,
  Joshua



Con Kolivas wrote:

> Joshua Schmidlkofer wrote:
>
>> I upgraded from 2.6.8.1-ck5.
>>
>> First off - this has been a landmark improvement for me.   Running an 
>> "emerge -a world" on my system has gone from a matter of minutes to a 
>> matter of seconds.
>>
>> The performance has been !outstanding!. [Disclosure:  Using NVIDIA 
>> Binary Drivers]
>
>
> Great to hear. Thanks for feedback.
>
> Not sure about the xfs one... perhaps it's related to the cfq one.
>
>> Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
>
>
> Known issue. There is a fix posted already in my ckdev directory (as 
> posted by Jens Axboe). The stack dump, while annoying and causes a 
> stall for a couple of seconds I believe, is harmless. Please apply the 
> cfq2 fix in my ckdev directory for this to go away.
>
> http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ckdev/
>
> Cheers,
> Con


