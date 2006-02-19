Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWBSFoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWBSFoH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 00:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWBSFoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 00:44:07 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:52459 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750932AbWBSFoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 00:44:05 -0500
Date: Sun, 19 Feb 2006 00:44:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-reply-to: <200602181941.40093.dhazelton@enter.net>
To: linux-kernel@vger.kernel.org
Message-id: <200602190044.03914.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <878xt3rfjc.fsf@amaterasu.srvr.nix>
 <200602181215.30277.gene.heskett@verizon.net>
 <200602181941.40093.dhazelton@enter.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 19:41, D. Hazelton wrote:
>On Saturday 18 February 2006 12:15, Gene Heskett wrote:
>> On Saturday 18 February 2006 07:06, Christoph Hellwig wrote:
>>
>> cat /proc/sys/dev/cdrom/info
>> CD-ROM information, Id: cdrom.c 3.20 2003/12/17
>>
>> drive name:             hdc
>> drive speed:            48
>> drive # of slots:       1
>> Can close tray:         1
>> Can open tray:          1
>> Can lock tray:          1
>> Can change speed:       1
>> Can select disk:        0
>> Can read multisession:  1
>> Can read MCN:           1
>> Reports media changed:  1
>> Can play audio:         1
>> Can write CD-R:         1
>> Can write CD-RW:        1
>> Can read DVD:           1
>> Can write DVD-R:        1
>> Can write DVD-RAM:      0
>> Can read MRW:           1
>> Can write MRW:          1
>> Can write RAM:          1
>
>Ah, so it does already exist. Only thing left might be to stick the
>manufacturer, serial and misc. data into sysfs
>
>> But I fail to see where this would help to 'find' the right device
>> to write to, other than the obvious prefixing of '/dev/' to $drive
>> name. We already knew that, and in fact it works very well. Please
>> explain to Joerg in one syllable words he might, if he wanted to,
>> understand.
>
>Well, in this case I'm actually trying to work with Joerg to produce a
> patch that unifies the ATAPI and SCSI busses inside his program. One
> thing this does is help to locate available drives. Negates the need
> to scan the entire ATA/ATAPI bus for drives. However, since, as Joerg
> has pointed out, libscg is a generic SCSI system, it doesn't negate
> it's need to scan the entire SCSI bus. It's use as a backend to
> cdrecord is incidental in this case.

Working with Joerg?  sigh

>> Also, I'm fuzzy about the last 3, so defining those might help me
>> understand.
>
>I've seen the "MRW" stuff in some of the specs, but had to check the
> net to find out what it was. MRW is the Mt. Rainier format - basic
> support was added by Jens back in 2.4.19 according to the archives.
>(http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/1214.html)
>
>I'm not positive, but the "Can Read RAM" line might refer to DVD-RAM
> type discs

That sounds like it makes sense, thanks.  I bought a spindle of 
rewritable dvd's, thinking about doing backups, but a 200GB drive and 
vtapes got in the way and its beaucoupe more convienient and speedy 
that the dvd's will ever be.  Once setup, it Just Works(TM).

That drive has since went belly up & been replaced with another that 
seems even more solid, liteon of course.

>DRH

Thanks

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
