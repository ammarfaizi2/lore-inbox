Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVLFTCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVLFTCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVLFTCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:02:12 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:13558 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030183AbVLFTCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:02:10 -0500
Date: Tue, 06 Dec 2005 14:02:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <4395798D.6040201@eclis.ch>
To: linux-kernel@vger.kernel.org
Message-id: <200512061402.08709.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512052301.16998.gene.heskett@verizon.net> <4395798D.6040201@eclis.ch>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 06:44, Jean-Christian de Rivaz wrote:
>Gene Heskett a écrit :
>>>Hmmm. Indeed the nforce2 has had a number of problems, but I'm not
>>> sure why it would have changed recently. Can you bound at all the
>>> kernel versions where it worked and where it broke? Additionally, do
>>> be sure you have the most recent BIOS, I've seen a number of nforce2
>>> issues be resolved with a BIOS update.
>>
>> I've already put more powerdown cycles (60 some) on my hard drives
>> fighting with the recent tv card problem, I'd like to get some uptime
>> in.  All I know for sure is if I build 2.6.15-rc5 with acpi, ntpd
>> doesn't work.  ntpdate does, but ntpd doesn't.  And both dmesg and
>> the ntp.log (and -d's passed at launch time do not make it more
>> verbose, they just keep it from starting) are silent as to the diffs
>> other than the interrupt number shuffling in dmesg when its on.  But
>> I suspect it may have started with 2.6.15-rc2, and I didn't build
>> rc1.  And I *think* it worked as recently as 2.6.14.1 with it turned
>> on.  I've cleaned house in /usr/src's so I don't have anything older.
>>  Sorry.
>
>I have to agree with John Stultz. I am one with a nForce2 chipset where
>updating to the latest BIOS have totaly solved the excatly same ntpd
>problem.

Problems: I went and got a newer bios, for a Biostar N7NCD-Pro, put it 
on a floppy and rebooted.  Going into the bios I chose to update it as 
that is part of the existing bios, no awardflash.exe needed according to 
the propaganda.  But the bios can't find it on the floppy.

Or do I still need awardflash.exe on the floppy too?  I'll put it there 
and try again.
------
Several reboots later, I still haven't managed to get it updated.

The first problem was that the builtin bios flasher couldn't find the 
file on the floppy, presumably because while vfat shows the correct name 
of ncdp1102bf.exe, a dos boot or compatible dir util can't see it as 
anything but ncdp11~1.exe.  So I put their latest awdflash.exe on the 
disk too.  Same deal except I had it save the old bios as oldbios.exe, 
and it can see that, but not the new file until I renamed it to 
something short enough for an idiot dos, ncdpbf.exe.

So, having arrived as a dos compatible name, I tried again, but now its 
bitching about a file size error and still refuses to do the update 
using their instructions to recover a bad update.  And the builtin bios 
flasher still can't see the shortened name.  I don't see a filesize 
error in the ls -l's below either.

An ls -l on that floppy shows:
[root@coyote root]# ls -l /mnt/floppy
total 563
-rwxr-xr-x  1 root root  47916 Dec  6 13:23 awdflash.exe
-rwxr-xr-x  1 root root 266240 Dec  6 13:24 ncdpbf.exe
-rwxr-xr-x  1 root root 262144 Dec  6  2005 oldbios.exe


An ls -l on the /dos dir of my hd, grepped for ncdp:
-rwxr-xr-x  1 root root 266240 Sep 16  2004 ncdp0730bf.exe
-rwxr-xr-x  1 root root 266240 Dec  6 12:10 ncdp1102bf.exe

The ncdp0730bf.exe is the file thats in the bios now, and which was then 
saved using the awdflash.exe as oldbios.exe thats on that disk now. 
FWIW, awdflash.exe CAN see the oldbios.exe file just fine.  I have now 
downloaded the new one twice from biostar.com.tw.

Has anyone got a clue as to what the heck is wrong here?

>Regards,

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
