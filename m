Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVATWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVATWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVATWZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:25:57 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:46046 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262187AbVATWZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:25:35 -0500
Message-ID: <41F02FDC.7090006@mnsu.edu>
Date: Thu, 20 Jan 2005 16:25:32 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
CC: Norbert van Nobelen <Norbert@edusupport.nl>, linux-kernel@vger.kernel.org
Subject: Re: LVM2
References: <1106250687.3413.6.camel@localhost.localdomain>	 <200501202240.02951.Norbert@edusupport.nl> <1106259457.3413.19.camel@localhost.localdomain>
In-Reply-To: <1106259457.3413.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFS is an SGI project.
http://oss.sgi.com/

I've been using it for quite a while and am quite happy with it; it is 
very fast and very fault tolerant.  The only warning I'd like to give 
about it is it seems that some Linux developers seem to have a bad taste 
in their mouth when it comes to XFS; go figure.

-- 
jeffrey hundstad

Trever L. Adams wrote:

>It is for a group. For the most part it is data access/retention. Writes
>and such would be more similar to a desktop. I would use SATA if they
>were (nearly) equally priced and there were awesome 1394 to SATA bridge
>chips that worked well with Linux. So, right now, I am looking at ATA to
>1394.
>
>So, to get 2TB of RAID5 you have 6 500 GB disks right? So, will this
>work within on LV? Or is it 2TB of diskspace total? So, are volume
>groups pretty fault tolerant if you have a bunch of RAID5 LVs below
>them? This is my one worry about this.
>
>Second, you mentioned file systems. We were talking about ext3. I have
>never used any others in Linux (barring ext2, minixfs, and fat). I had
>heard XFS from IBM was pretty good. I would rather not use reiserfs.
>
>Any recommendations.
>
>Trever
>
>P.S. Why won't an LV support over 2TB?
>
>S.P.S. I am not really worried about the boot and programs drive. They
>will be spun down most of the time I am sure.
>
>On Thu, 2005-01-20 at 22:40 +0100, Norbert van Nobelen wrote:
>  
>
>>A logical volume in LVM will not handle more than 2TB. You can tie together 
>>the LVs in a volume group, thus going over the 2TB limit. Choose your 
>>filesystem well though, some have a 2TB limit too.
>>
>>Disk size: What are you doing with it. 500GB disks are ATA (maybe SATA). ATA 
>>is good for low end servers or near line storage, SATA can be used equally to 
>>SCSI (I am going to suffer for this remark).
>>
>>RAID5 in software works pretty good (survived a failed disk, and recovered 
>>another failing raid in 1 month). Hardware is better since you don't have a 
>>boot partition left which is usually just present on one disk (you can mirror 
>>that yourself ofcourse).
>>
>>Regards,
>>
>>Norbert van Nobelen
>>
>>On Thursday 20 January 2005 20:51, you wrote:
>>    
>>
>>>I recently saw Alan Cox say on this list that LVM won't handle more than
>>>2 terabytes. Is this LVM2 or LVM? What is the maximum amount of disk
>>>space LVM2 (or any other RAID/MIRROR capable technology that is in
>>>Linus's kernel) handle? I am talking with various people and we are
>>>looking at Samba on Linux to do several different namespaces (obviously
>>>one tree), most averaging about 3 terabytes, but one would have in
>>>excess of 20 terabytes. We are looking at using 320 to 500 gigabyte
>>>drives in these arrays. (How? IEEE-1394. Which brings a question I will
>>>ask in a second email.)
>>>
>>>Is RAID 5 all that bad using this software method? Is RAID 5 available?
>>>
>>>Trever Adams
>>>--
>>>"They that can give up essential liberty to obtain a little temporary
>>>safety deserve neither liberty nor safety." -- Benjamin Franklin, 1759
>>>
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>      
>>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>--
>"Assassination is the extreme form of censorship." -- George Bernard
>Shaw (1856-1950)
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
