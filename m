Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVIGRFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVIGRFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVIGRFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:05:38 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:41890 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1750882AbVIGRFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:05:37 -0400
Message-ID: <431F1DBB.8020107@cs.wisc.edu>
Date: Wed, 07 Sep 2005 12:04:59 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: boutcher@cs.umn.edu
CC: Christoph Hellwig <hch@lst.de>, Vladislav Bolkhovitin <vst@vlnb.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Santiago Leon <santil@us.ibm.com>,
       Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
References: <20050906212801.GB14057@cs.umn.edu> <20050907104932.GA14200@lst.de> <20050907124504.GA13614@cs.umn.edu>
In-Reply-To: <20050907124504.GA13614@cs.umn.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave C Boutcher wrote:
> On Wed, Sep 07, 2005 at 12:49:32PM +0200, Christoph Hellwig wrote:
> 
>>On Tue, Sep 06, 2005 at 04:28:01PM -0500, Dave C Boutcher wrote:
>>
>>>This device driver provides the SCSI target side of the "virtual
>>>SCSI" on IBM Power5 systems.  The initiator side has been in mainline
>>>for a while now (drivers/scsi/ibmvscsi/ibmvscsi.c.)  Targets already
>>>exist for AIX and OS/400.
>>
>>Please try to integrate that with the generic scsi target framework at
>>http://developer.berlios.de/projects/stgt/.
> 
> 
> There hasn't been a lot of forward progress on stgt in over a year, and
> there were some issues (lack of scatterlist support, synchronous and
> serial command execution) that were an issue when last I looked.
> 

stgt is not scst. It is new. And yes we will have proper support for 
sccatterlists. We need something similar to what sg and st need so I 
plan on using the block layer functions that are implemented for those 
upper layer drivers for stgt. If you want to help out and implement that 
then that would be good. We are also very early in our design so all 
comments are welcome.
