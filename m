Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbSJGFKT>; Mon, 7 Oct 2002 01:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262867AbSJGFKS>; Mon, 7 Oct 2002 01:10:18 -0400
Received: from [203.117.131.12] ([203.117.131.12]:28612 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262866AbSJGFKR>; Mon, 7 Oct 2002 01:10:17 -0400
Message-ID: <3DA11884.7050004@metaparadigm.com>
Date: Mon, 07 Oct 2002 13:15:48 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
References: <200210061103.g96B3mlO001484@darkstar.example.net>	 <3DA02BF2.2040506@metaparadigm.com>  <1033933235.2436.1.camel@localhost>	 <1033946058.2436.13.camel@localhost> <1033966448.1512.2.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/02 12:54, GrandMasterLee wrote:
> On Sun, 2002-10-06 at 18:14, GrandMasterLee wrote:
> 
> 
>>I just reassigned all my LUNs to be a part of the same host
>>configuration on the storage(polling by HBAs and host, versus splitting
>>LUNs by HBA). I do get more than 1 LUN now, but only EVEN luns. I'll see
>>if I can identify why that is. 
> 
> 
> After defining LSI in drivers/scsi/scsi_scan.c I can get half my luns,
> but still not all. I'm not sure what else I need to do. I now can see
> LUNs 0,2,4,6,8, etc but not 1,3,5,7,etc. I'm not sure what else to do,
> but maybe now that I've done this, I can get information from QLogic
> about what should be happening. Or does this still seem like a kernel
> config issue? 

So sparse lun scanning is working then - sounds like your missing luns
is a problem with your array configuration as the kernel is probing them
(if it is was creating the even ones) - means the qlogic driver must
not be able to see these luns. Not familiar with your array so can't
help any more - your array vendor would probably be the most help.

~mc

