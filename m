Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTL2Bg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTL2Bg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:36:59 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:48285 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262280AbTL2Bg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:36:57 -0500
Message-ID: <3FEF8536.3030204@wmich.edu>
Date: Sun, 28 Dec 2003 20:36:54 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Samuel Flory <sflory@rackable.com>, Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Can't eject a previously mounted CD?
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org> <3FEC91FA.1050705@rackable.com> <20031226202700.GD12871@triplehelix.org> <3FEF7359.9050900@rackable.com> <3FEF7528.1000301@wmich.edu>
In-Reply-To: <3FEF7528.1000301@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does everyone who has this problem by chance have it occuring on an 
atapi cd recorder.  As of 2.6.0-mm1 my cd recorder is being labeled read 
only by the ide-cd driver.  Meaning, no matter if i set the readonly 
flag in hdparm to 0, cdrecord and others will refuse to write to the 
drive because it's being told it's read only.  I do not have fam loaded 
at the time of this testing.  Are there new ide-cd arguments required to 
use atapi cd writers in native mode?





Ed Sweetman wrote:
> Samuel Flory wrote:
> 
>> Joshua Kwan wrote:
>>
>>> On Fri, Dec 26, 2003 at 11:54:34AM -0800, Samuel Flory wrote:
>>>
>>>>  What does fuser -kv /mnt/cdrom claim?
>>>
>>>
>>>
>>>
>>> It's /cdrom here. I tried it on both /cdrom and /dev/cdrom after
>>> unmounting it, and the output was blank.
>>>
>>> While mounted, here was the output:
>>>
>>>                      USER        PID ACCESS COMMAND
>>> /cdrom               root     kernel mount  /cdrom
>>> No automatic removal. Please use  umount /cdrom
>>>
>>> I guess that doesn't say much though...
>>>
>>
>>   It does seem to imply that the cdrom is still mounted, or that 
>> something thinks it's still mounted.
> 
> 
> 
> I dont believe this unable to eject problem has anything to do with 
> anything thinking it's mounted.
> 
> famd upon load seems to cause this error.
> end_request: I/O error, dev hdc, sector 0
> 
> That's my cdrom.  Perhaps the kernel has a bug in the code dealing with 
> an access to the cdrom where no media is mounted and/or loaded.  Either 
> way, this is at boot and seems to be a kernel bug initiated by FAM. At 
> least the version distributed with debian-unstable.  I dont use gnome (i 
> do have some gnome programs installed to test on) and the error message 
> was reported soon after the loading of FAM.
>

