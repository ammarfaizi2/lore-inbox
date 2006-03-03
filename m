Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWCCTOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWCCTOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 14:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCCTOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 14:14:09 -0500
Received: from roadrunner-base.egenera.com ([63.160.166.46]:6104 "EHLO
	roadrunner-base.egenera.com") by vger.kernel.org with ESMTP
	id S1751361AbWCCTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 14:14:07 -0500
In-Reply-To: <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org> <4405E8AA.1090803@rtr.ca> <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org> <CF493E39-B369-46D8-85EE-013F2484F1C6@egenera.com> <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <850B5C8B-1859-4B1B-9133-79C8DA076DC1@egenera.com>
Cc: Mark Lord <lkml@rtr.ca>, Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Steve Byan <smb@egenera.com>
Subject: Re: sg regression in 2.6.16-rc5
Date: Fri, 3 Mar 2006 14:13:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.746.2)
X-OriginalArrivalTime: 03 Mar 2006 19:13:15.0200 (UTC) FILETIME=[85A99C00:01C63EF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 3, 2006, at 1:55 PM, Linus Torvalds wrote:

>
>
> On Fri, 3 Mar 2006, Steve Byan wrote:
>>
>> On Mar 1, 2006, at 1:42 PM, Linus Torvalds wrote:
>>>
>>> I wouldn't expect it to. Most people use ATA for that, and it  
>>> tends to
>>> have lower limits than most SCSI HBA's (well, at least the old  
>>> PATA), so
>>> the change - if any - should at most change some of the sg.c  
>>> limits to be
>>> no less than what SG_IO has had on ATA forever.
>>>
>>> Not that I expect people to have a SCSI CD/DVD drive anyway in  
>>> this day
>>> and age, so the sg.c changes probably won't show up at all.
>>
>> CD-ROM support is a frequently-requested feature on the iSCSI  
>> Enterprise
>> Target (iet) email list. It won't be long before iSCSI CD and DVD  
>> devices
>> start showing up, although the underlying hardware will be ATAPI  
>> or else
>> missing entirely (i.e. ISO image file).
>
> Yes, but the point that the ATA limits tend to be on the low side  
> still
> stands.
>
> For example, I think the IDE driver defaults to a maximum transfer  
> of 256
> sectors, and the same number of max scatter-gather entries. Some
> controllers will actually lower that, due to silly hw problems.
>
> The point being that it has worked fine for IDE, and if a SCSI  
> controller
> has noticeably lower limits than that, there's something really  
> strange
> going on, like a real bug.

Yes, you are correct. I wasn't intending to contest your main point.  
I only intended to point out that ignoring bugs because no-one uses  
SCSI DVDs will soon lead to much grief.

Regards,
-Steve
-- 
Steve Byan <smb@egenera.com>
Software Architect
Egenera, Inc.
165 Forest Street
Marlboro, MA 01752
(508) 858-3125


