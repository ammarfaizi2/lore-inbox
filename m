Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUKOUTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUKOUTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUKOUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:19:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:42638 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261338AbUKOUTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:19:49 -0500
Message-ID: <41991036.8020404@tmr.com>
Date: Mon, 15 Nov 2004 15:23:18 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: deadlock with 2.6.9
References: <200411122248_MC3-1-8E97-BFE6@compuserve.com>
In-Reply-To: <200411122248_MC3-1-8E97-BFE6@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Sun, 07 Nov 2004 at 09:22:14 +0100 Bernd Eckenfels wrote:
> 
> 
>>>Get a real RAID controller (3Ware, not some crappy pseudo-RAID junk.)  They are
>>>much more reliable than software RAID.
>>
>>On what sample do you base this claim?
>>
>>Generally hardware raid sooner or later makes problems (especially if you
>>run raid5 in degenerate mode or try to rebuild by disk replacing with
>>differen/old signature). Also bus hangs are commonly not very well received
>>by hw raid firmware or drivers.
> 
> 
>   I had 28 mirror sets on Compaq SMART2/p controllers in one server (four
> controllers, two SCSI channels each, seven disks per channel.)  All the disks
> on channel A of each controller were mirrored to those on channel B, so even
> complete failure of one channel didn't cause a problem.
> 
>   Once a disk was marked 'failed' in the controller NVRAM there was no way to
> convince it that some newly-inserted disk contained valid data.
> 
>   Booting up with SCSI cables connected wrongly (channels A and B swapped) got you
> a nice error message informing you of this fact.  Swapping SCSI IDs on different
> disks on the same channel was also detected and reported nicely.
> 
>   And attempting to boot with a bad cable (bent pin) gave a message saying 'either
> power down NOW and check cables or I will mark every disk on that channel as
> failed.'
> 
>   Of course this system was 100% Compaq; even the disks had Compaq firmware
> though the labels said IBM.  And it was very expensive...

I have had quite good luck with the IBM "ServeRAID" controllers, running 
30+ systems with one or two of them and between 1-10TB storage. To 
convince the controller that a drive marked bad really is good does 
require shutting down the system and saying reassuring things to the 
firmware from the console, but it can be done. I'm told that I may be 
able to do that running now, using the control application, but given 
that the servers are spread over four timezones I have no urge to try 
the remote version.

I would like to have some form of hardware RAID on at least what I need 
to boot, so a failure of one of the boot drives doesn't leave the 
machine unable to boot. Particularly with (S)ATA systems which tend to 
fail to the mirror only when the first drive is *dead*, not when it's 
too sick to give good data, but still trying.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
