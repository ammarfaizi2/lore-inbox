Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSGNO4e>; Sun, 14 Jul 2002 10:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSGNO4d>; Sun, 14 Jul 2002 10:56:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49412 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316882AbSGNO4c> convert rfc822-to-8bit; Sun, 14 Jul 2002 10:56:32 -0400
Message-ID: <3D3184EF.8040109@evision-ventures.com>
Date: Sun, 14 Jul 2002 16:04:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Paul Bristow <paul@paulbristow.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl> <3D2EE7BA.8080805@evision-ventures.com> <3D313412.1030102@paulbristow.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Paul Bristow napisa³:
> 
> 
> Martin Dalecki wrote:
> 
>> Workarouns in ide-floppy - ZIP drives and Clock drives.
>>
>> Those are the main "technical issues" which make one hessitate.
>>  
>>
> Sorry, late to this thread.  Look, ide-floppy has to deal with real 
> world devices, which simply don't follow nice, written specifications. 
> If we treat these devices as standard ATAPI they simply don't work.
> 
> And a bunch of planned features which were waiting for 2.5 but are now 
> in limbo until the IDE subsystem is stable enough for me to work on. 
> Features include:
> 
> Trying again to kill the via chipset/Zip interaction (some people are 
> still suffering).
> 
> Kevin Flemings media detect work: needs ATA commands because the ATAPI 
> command set simply doesn't return the information we need.  Then we can 
> make ide-floppy drives work *properly* with devfs.
> 
> Handling the "special" BIOS settings around LS-120/240/Zip bootable 
> drives. 
> Making sure that formatting works properly for non-standard format 
> capacities (i.e. 1.44MB in LS-120, 32MB in LS-240)
> 
> And yes, I have real users asking for these things.
> 
> So to me the problem is not to make everything work as SCSI, because 
> that simply isn't true for ide-floppy devices.  They *nearly* work, so 
> you can get kludgy, "good enough for command line gurus" working with 
> ide-scsi, but there are some funnies.  Does it really make sense to have 
> IDE/ATAPI kludges down in the SCSI tree?
> 
> I much prefer Linus's suggestion of agreeing on the top level API.  I 

Just to make things clear. Personally I by no way think
that ide-scsi should remain an SCSI device. My concern is only the
fact that it would be easier in my opinnion to start off with
ide-scsi and make it *independant* from the SCSI code or device handling
by separating commonly used code for MMC_ handling out of SCSI
in a kind of library (that is it) and not a common "layer"
(this could be a second step).

However this can be accomplished the other way around as well.
It will be just considerable more work.

