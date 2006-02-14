Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030537AbWBNJtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbWBNJtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWBNJtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:49:19 -0500
Received: from lucidpixels.com ([66.45.37.187]:48076 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030537AbWBNJtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:49:18 -0500
Date: Tue, 14 Feb 2006 04:49:17 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: Linda Walsh <lkml@tlinx.org>, smartmontools-support@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: default hdparms? readahead=256? Re: WD 400GB xATA Drives
In-Reply-To: <43F15027.2090304@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602140448430.3567@p34>
References: <Pine.LNX.4.64.0602130524350.13160@p34> <43F1393D.9050801@tlinx.org>
 <43F15027.2090304@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out I had too many devices in the box, I have removed them now, 
still getting those pesky drive errors though, I will try the hdparm soon, 
thanks.


On Mon, 13 Feb 2006, Mark Lord wrote:

> Linda Walsh wrote:
>> ..
>> set to known values may not contain "great values".  My "readahead"
>> value seems to boot with a value of "256" for all of my drives.
>> 
>> Is this not a bit "excessive"?
>
> Wow.. that does look a bit HUGE.  Thanks for pointing it out,
> I'm resetting mine back to 128 for now.
>
>> Justin Piszcz wrote:
>>> When I write to this disk for a while, I see this in dmesg (only once so 
>>> far):
>>> 
>>> [31230.223504] ata6: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
>>> 0xb/00/00
>>> [31230.223511] ata6: status=0x51 { DriveReady SeekComplete Error }
>>> [31230.223515] ata6: error=0x04 { DriveStatusError }
>>> 
>>> Is there some sort of smart testing going on constantly?  I only get 
>>> 26-27MB/s on this 400GB/SATA/16MB/7200RPM drive.  I use smartmontools to 
>>> do a daily test.  However, even with smart disabled, I get:
>>> 
>>> # hdparm -t /dev/sde
>>> /dev/sde:
>>>  Timing buffered disk reads:   78 MB in  3.06 seconds =  25.46 MB/sec
>>> 
>>> Does anyone know if this drive has problems in Linux or something?
>>> 
>>> [    6.895914]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
> ...
>
> Some drives suck at sequential reads, in favour of doing random seeks
> very very well.  Basically, the on-drive seek algorithm may not favour
> doing much read-ahead.  Try "hdparm -A1" and see if that helps.
>
