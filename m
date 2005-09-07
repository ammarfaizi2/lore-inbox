Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVIGS4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVIGS4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVIGS4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:56:48 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:29859 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1750831AbVIGS4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:56:47 -0400
Message-ID: <431F37E6.3080706@cs.wisc.edu>
Date: Wed, 07 Sep 2005 13:56:38 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladislav Bolkhovitin <vst@vlnb.net>
CC: boutcher@cs.umn.edu, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Santiago Leon <santil@us.ibm.com>,
       Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
References: <20050906212801.GB14057@cs.umn.edu> <20050907104932.GA14200@lst.de> <20050907124504.GA13614@cs.umn.edu> <431F35D2.7040209@vlnb.net>
In-Reply-To: <431F35D2.7040209@vlnb.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladislav Bolkhovitin wrote:
> Dave C Boutcher wrote:
> 
>> On Wed, Sep 07, 2005 at 12:49:32PM +0200, Christoph Hellwig wrote:
>>
>>> On Tue, Sep 06, 2005 at 04:28:01PM -0500, Dave C Boutcher wrote:
>>>
>>>> This device driver provides the SCSI target side of the "virtual
>>>> SCSI" on IBM Power5 systems.  The initiator side has been in mainline
>>>> for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
>>>> exist for AIX and OS/400.
>>>
>>>
>>> Please try to integrate that with the generic scsi target framework at
>>> http://developer.berlios.de/projects/stgt/.
>>
>>
>>
>> There hasn't been a lot of forward progress on stgt in over a year, and
>> there were some issues (lack of scatterlist support, synchronous and
>> serial command execution) that were an issue when last I looked.
>>
>> Vlad, can you comment on the state of stgt and whether you see it
>> being ready for mainline any time soon?
> 
> 
> Sorry, I can see on stgt page only mail lists archive and not from start 
> (from Aug 22). Mike, can I see stgt code and some design description, 
> please? You can send it directly on my e-mail address, if necessary.


goto the svn page for the code
http://developer.berlios.de/svn/?group_id=4492

As for design desc, I do not have anything. It is the evolving source :) 
We are slowly merging leasons we learned from open-iscsi, your SCST 
code, the available software and HW targets, and the SCSI ULD's 
scatterlist code which needs redoing so it is a bit of a mess.
