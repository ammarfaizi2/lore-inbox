Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268935AbRHBOHA>; Thu, 2 Aug 2001 10:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268936AbRHBOGv>; Thu, 2 Aug 2001 10:06:51 -0400
Received: from web12503.mail.yahoo.com ([216.136.173.195]:25609 "HELO
	web12503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268933AbRHBOGb>; Thu, 2 Aug 2001 10:06:31 -0400
Message-ID: <20010802140639.24652.qmail@web12503.mail.yahoo.com>
Date: Thu, 2 Aug 2001 07:06:39 -0700 (PDT)
From: Karcaw <Karcaw@rocketmail.com>
Subject: Re: [RFT] Support for ~2144 SCSI discs
To: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc: devfs-announce-list@mobilix.ras.ucalgary.ca
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am pleased to see this, I recently expanded the majors number range
on my system from 8 majors to 32 by just pushing the secondary range
from 65-71 to 65-95, This solution Stomped on other majors, COMPAQ
SMART array and IDE6-9, etc. I did not think this was a viable solution
to the mainstream kernel so I have only been using it here.  I am glad
someone with more experience is fixing this one.  I am currently
working with linux on a the HP VA7100 that can support up to 1024 LUNS
(limited by fibre Channel HBAs to 256 or 128) on a single device, so I
am using up disks very quickly with only 128 availible. 

One questions I have on the patch:
-in drivers/char/sysrq.c:is_local_disk(...) references the SCSI major
numbers, should it change for this patch?

I wrote a patch for the Scsi Generic Driver that uses devfs to extend
the numbers of genric devices beyond the 256 minor limit.  It will use
as many major/minor numbers that it can get from devfs for generic scsi
drivers.  it can be found on the official sg web site at:
http://gear.torque.net/sg/ as an experimental driver(sg3120df).

Evan Felix


--- Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
>   Hi, all. Below is a patch that adds support for large numbers of
> SCSI discs (approximately 2144). I'd like people to try this out. I'm
> not doing my normal devfs-patch-v??? thing because this is completely
> untested (I'm away from my SCSI boxes), and I don't want to put a
> possibly FS-corrupting patch on my ftp archive. The code does compile
> and link, though.
> 
> There are 3 cases I'd like to have tested:
> - people with 1 to 16 SCSI discs
> - people with 17 to 128 SCSI discs
> - people with >128 SCSI discs
> 
> because each of these exercises a slightly different setup path.
> Please send success or failure reports to me.
> 
> REMINDER: be careful with this patch. It could corrupt your FS.
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca




=====
---------
Evan Felix
Karcaw@rocketmail.com
---------

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
