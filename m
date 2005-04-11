Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVDKBV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDKBV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 21:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVDKBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 21:21:58 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:4060 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261654AbVDKBVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 21:21:16 -0400
Date: Sun, 10 Apr 2005 21:21:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: formatting CD-RW locks the system
In-reply-to: <200504102136.09229.s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Message-id: <200504102121.11367.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <42597088.9050004@aknet.ru>
 <200504102136.09229.s0348365@sms.ed.ac.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 April 2005 16:36, Alistair John Strachan wrote:
>On Sunday 10 Apr 2005 19:29, you wrote:
>> Hello.
>>
>> I am trying to format the CD-RW disc
>> on my NEC ND-3520A DVD writer, and the
>> results are completely unexpected: I do
>> cdrwtool -d /dev/cdrom -q
>> It proceeds with the formatting, but
>> while it does so, the system is pretty
>> much dead. It can do some trivial tasks
>> like the console switching, but as soon
>> as it comes to any disc I/O, the processes
>> are hanging. After the formatting is done,
>> the system is back alive. That reminds me
>> formatting the floppies under DOS in those
>> ancient times, with the only difference
>> that formatting a floppy takes ~2 minutes,
>> while formatting a CD-RW takes ~20 minutes,
>> which is not good at all.
>> Is this something known or a bug?
>> I tried that on a 2.6.11-rc3-mm2 and
>> on a 2.6.12-rc1 kernels.
>>
>> Also, is there any way to use the
>> packet writing with the CD-R/DVD-R discs,
>> or is it supposed to work only with the
>> -RW discs?
>
>You probably don't have DMA enabled on the drive. Please check this.
>
>CDRW formatting works fine here with cdrecord blank=all

Excuse me, but did I miss a major left turn in the operations of a 
disk control system here someplace?

Every disk system I have ever delt with, has as a default, (and I've 
walked around in a couple of them at the assembly language level) the 
assumption that if track 0 is to be formatted, then the whole device 
is assumed to be needing formatted, and every filesystem I've ever 
screwed with will do exactly that.  Often, but not always, that can 
actually be offloaded to the device itself if its smart enough, and 
the operating system itself can go on about its business, whether its 
you composing a letter to your aunt Tilly or whatever.

IDE/ATAPI drives have been cheerfully ignoreing format messages from 
the OS now for what, 12 years now unless backed up by super secret 
code word access to such builtin functions of the drive, only 
possessed by the factory technicians who do have the tools to control 
the track spaceings and data densities on the surfaces etc etc?

Scsi drives have been reporting the success of the formatting 
operation in just a few milliseconds for even longer simply because 
they take care of their own errors long before the os is aware the 
drive may be having problems?  The last time I formatted a scsi drive 
under nitros9, the format took 10 milliseconds, but the logical 
installation of the filesystem took another 3 hours, mainly because 
nitros9 uses a 256 byte sector.

Its possible the cd-rw folks seem to have fallen off the wagon here, 
but really, a disk operating system (and the average cd-rw or dvd-rw 
drive should be capable of doing that with no further intervention 
from the OS itself unless you want some sort of a non-standard 
formatting done as in the nitros0 situation.

Are the firmwares of modern cd/dvd writers actualy dumb enough they 
need the OS's help for that?  If the answer is yes, lord help us.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
