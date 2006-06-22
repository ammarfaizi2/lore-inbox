Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWFVU3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWFVU3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWFVU3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:29:07 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:56968 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1030399AbWFVU3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:29:03 -0400
Message-ID: <449AFD9E.3070308@eecs.berkeley.edu>
Date: Thu, 22 Jun 2006 13:29:18 -0700
From: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: petabyte class archival filestore wanted/proposed
References: <449AC8A0.6020108@eecs.berkeley.edu> <449AF53B.10103@garzik.org>
In-Reply-To: <449AF53B.10103@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Jeff Anderson-Lee wrote:
>
>> I'm part of a project at University of California Berkeley that is 
>> trying to put together a predominantly archival file system for 
>> petabyte class data stores using Linux with clusters of commodity 
>> server hardware.  We currently have multiple terabytes of hardware on 
>> top of which we intend to build such a system.  However, our hope is 
>> that the end system would be useful for a wide range of users from 
>> someone with 3 large disk or three disk servers to groups with 3 or 
>> more distributed storage sites.
>>
>> Main Goals/Features:
>>    1) Tapeless: maintain multiple copies on disk (minimize 
>> backup/restore lag)
>>    2) "Mirroring" across remote sites: for disaster recovery (we sit 
>> on top of  the Hayward Fault)
>>    3) Persistent snapshots: as archival copies instead of 
>> backup/restore scanning
>>    4) Copy-On-Write: in support of snapshots/archives
>>    5) Append-mostly log structured file system: make synchronization 
>> of remote mirrors easier (tail the log).
>>    6) Avoid (insofar as possible) single point of failure and 
>> bottlenecks (for scalability)
>>
>> I've looked into the existing file systems I know about, and none of 
>> them seem to fit the bill.
>>
>> Parts of the Open Solaris ZFS file system looks interesting, except 
>> (a) it is not on Linux and (b) seems to mix together too many levels 
>> (volume manager and file system).  I can see how using some of the 
>> concepts and implementing something like it on top of an 
>> append-mostly distributed logical device might work however.  By 
>> splitting the project into two parts ((a) a robust, distributed 
>> logical block device and (b) a flexible file system with snapshots)  
>> it might make it easier to design and build.
>>
>> Before we begin however, it is important to find out:
>>    1) Is there anything sufficiently like this to either (a) use 
>> instead, or (b) start from.
>>    2) Is there community support for insertion in the main kernel 
>> tree (without which it is just another toy project)?
>>    3) Anyone care to join in (a) design, (b) implementation, or (c) 
>> testing?
>
>
> I would recommend checking out Venti:
> http://cm.bell-labs.com/sys/doc/venti.html 

Yes, I've seen that and like some of the ideas.  There is no GPL Linux 
implementation of Venti that I know of.

Jeff Anderson-Lee

