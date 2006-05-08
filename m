Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWEHUVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWEHUVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWEHUVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:21:04 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50104 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751302AbWEHUVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:21:03 -0400
Date: Mon, 8 May 2006 22:20:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Greaves <david@dgreaves.com>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make kernel ignore bogus partitions
In-Reply-To: <445F64E2.3000902@dgreaves.com>
Message-ID: <Pine.LNX.4.61.0605082214581.20743@yvahk01.tjqt.qr>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
 <20060508072701.GB15941@apps.cwi.nl> <445F64E2.3000902@dgreaves.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Sometimes partitions claim to be larger than the reported capacity of a
>>> disk device. This patch makes the kernel ignore those partitions.
>>>     
>> Or, while doing forensics on a disk one copies the start to some
>> other disk, and that other disk may be smaller.
>> Etc.
>>
>> So, it seems that Linux loses a little bit of its power when such things
>> are made impossible.
>>   
>I've had similar situations when trying to recover data from failed devices.
>Equally - if you don't know what's going on then partition/disk size
>mismatch is a bad thing.
>A loud warning may be more appropriate (and useful) than an ignore.

I also consider a warning message more helpful.
OTOH, what if the disk will be automounted at boot? The boot scripts 
won't catch it if it just a warning, whereas if it was ignored, no mount 
would occur.
Maybe a bootparam toggling warning/ignore as the solution?


Jan Engelhardt
-- 
