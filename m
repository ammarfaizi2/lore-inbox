Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314043AbSDKNIO>; Thu, 11 Apr 2002 09:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314045AbSDKNIN>; Thu, 11 Apr 2002 09:08:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57874 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314043AbSDKNIN>; Thu, 11 Apr 2002 09:08:13 -0400
Message-ID: <3CB57C1F.9060607@evision-ventures.com>
Date: Thu, 11 Apr 2002 14:05:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Jens Axboe <axboe@suse.de>, Martin Dalecki <martin@dalecki.de>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: New IDE code and DMA failures
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Hi Jens, Martin, Vojtech,

Zdrastwujtie.

> I have a flaky IDE subsystem in one box. Reads work fine,
> writes sometimes don't work and hang either IDE/block device
> sybsystem or entire box. For example, I dumped ~40 MB file to
> the disk and now I have additional power led (i.e. hdd activity
> led is constantly on) and a bunch of "D" state processes
> (kupdated, mount, umount).
> 
> This is happening since I decided to try 2.5.7.
> 2.4.18 reported DMA failures and reverted to PIO.
> 
> I did send a detailed report of similar event with
> ksymoopsed stack traces of hung prosesses to lkml.
> 
> Since you are working on IDE subsystem, I will be glad to
> *retain* my flaky IDE setup and test future kernels
> for correct operation in this failure mode.
> 
> Please inform me whenever you want me to test your patches.

Guessing from the symptoms I would rather suggest that:

1. Are you sure you have the support for your chipset properly
    enabled? It's allmost a must for DMA.

2. Could you please report about the hardware you have. There are
    chipsets around there which are using theyr own transport layer
    implementations. host chip (aka south bridge) disk types and so on.

3. Some timeout values got increased to more generally used values (in esp.
    IBM microdrives advice about timeout values. Could you see whatever
    the data doesn't eventually go to the disk after georgeous
    amounts of time.

4. Could you try to set the DMA mode lower then it's set up
    per default by using hdparm and try whatever it helps?

