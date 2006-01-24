Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWAXXBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWAXXBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWAXXBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:01:11 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:44466 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750813AbWAXXBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:01:09 -0500
Message-ID: <43D6B1B2.4080400@comcast.net>
Date: Tue, 24 Jan 2006 18:01:06 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
References: <43D5CC88.9080207@comcast.net> <1138116579.14675.22.camel@localhost.localdomain> <43D6A76D.2000502@comcast.net> <Pine.LNX.4.58.0601241426180.26036@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0601241426180.26036@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Tue, 24 Jan 2006, Ed Sweetman wrote:
>
>  
>
>>Alan Cox wrote:
>>
>>    
>>
>>>On Maw, 2006-01-24 at 01:43 -0500, Ed Sweetman wrote:
>>>
>>>
>>>      
>>>
>>>>problem.  The problem is that there appears to be two nvidia/amd ata
>>>>drivers and I'm unsure which I should try using, if i compile both in,
>>>>which get loaded first (i assume scsi is second to ide) and if i want my
>>>>pata disks loaded under the new libata drivers, will my cdrom work under
>>>>them too, or do i still need some sort of regular ide drivers loaded
>>>>just for cdrom (to use native ata mode for recording access).
>>>>
>>>>
>>>>        
>>>>
>>>The goal of the drivers/scsi/pata_* drivers is to replace drivers/ide in
>>>its entirity with code using the newer and cleaner libata logic. There
>>>is still much to do but my SIL680, SiS, Intel MPIIX, AMD and VIA boxes
>>>are using libata and the additional patch patches still queued
>>>
>>>
>>>      
>>>
>>>>1.  Atapi is most definitely not supported by libata, right now.
>>>>
>>>>
>>>>        
>>>>
>>>It works in the -mm tree.
>>>
>>>
>>>      
>>>
>>Intriguing, when I had no ide chipset compiled in kernel, only libata
>>drivers, I got no mention at all about my dvd writer.  I even had the
>>scsi cd driver installed and generic devices, still nothing seemed to
>>initialize the dvd drive.  It detected the second pata bus but no
>>devices attached to it.
>>
>>this is using the kernel mentioned in the subject header.
>>2.6.16-rc1-mm2.  using the amd/nvidia drivers for pata and sata.
>>
>>Is there anything i can do to give more info to the list to figure out
>>why my atapi writer is being ignored by pata even when there are no ide
>>drivers loaded?
>>    
>>
>
>Currently you need to use libata.atapi_enabled=1
>(assuming that libata is in the kernel image, not a loadable module).
>
>I just built/tested this also, working for me as well.
>(hard drives, not ATAPI)
>  
>
I assume libata.atapi_enabled=1 is a boot arg, not some structure member 
in the source for the pata driver that i need to set to 1, correct? 

And you just built and tested it, how did you test if the atapi argument 
worked when you then say "not ATAPI" as something you tested?

In any case, i'll try out libata.atapi_enabled=1 and see if it detects 
the dvd drive.



