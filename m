Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVBCM2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVBCM2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVBCM2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:28:53 -0500
Received: from alog0149.analogic.com ([208.224.220.164]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262948AbVBCM2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:28:40 -0500
Date: Thu, 3 Feb 2005 07:28:50 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Joe User DOS kills Linux-2.6.10
In-Reply-To: <20050203003334.GA5680@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.61.0502030725480.8811@chaos.analogic.com>
References: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
 <20050203003334.GA5680@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Andries Brouwer wrote:

> On Wed, Feb 02, 2005 at 01:23:43PM -0500, linux-os wrote:
>>
>> When I compile and run the following program:
>>
>> #include <stdio.h>
>> int main(int x, char **y)
>> {
>>     pause();
>> }
>> ... as:
>>
>> ./xxx `yes`
>>
>> ... the following occurs after about 30 seconds (your mileage
>> may vary):
>>
>> Additional sense: Peripheral device write fault
>> end_request: I/O error, dev sdb, sector 34605780
>> SCSI error : <0 0 1 0> return code = 0x8000002
>> Info fld=0x2100101, Deferred sdb: sense key Medium Error
>> Additional sense: Peripheral device write fault
>> end_request: I/O error, dev sdb, sector 34603748
>> SCSI error : <0 0 1 0> return code = 0x8000002
>> Info fld=0x2100103, Deferred sdb: sense key Medium Error
>
> When I run "sleep `yes`" under bash, all of swap space is filled,
> and then bash says "realloc error ..." and exits.
>
> No kernel problem, no bad bash problem.
>
> If you do not run vm overcommit mode 2 then probably your bash
> will be killed by the OOM killer, and if you are unlucky some
> other stuff might be killed as well.
>
> Concerning the SCSI errors, looks like you might have disk problems.
> Bad blocks in your swap space. Recheck the disk.
>
> Andries
>

I ran badblocks (all night). There were none. It's a SCSI disk
and it requires chunks of DMA RAM for each write. The machine
just croaks when it gets low on RAM and tries to write to
SCSI swap which requires RAM.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
