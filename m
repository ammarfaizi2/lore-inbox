Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267270AbUBMWue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267271AbUBMWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:50:20 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:50185 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267270AbUBMWtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:49:46 -0500
Message-ID: <402D5628.6070705@techsource.com>
Date: Fri, 13 Feb 2004 17:56:40 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1,
 etc.
References: <9792.1076675029@www11.gmx.net>
In-Reply-To: <9792.1076675029@www11.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Blueman wrote:
> Willy Tarreau <willy@w.ods.org> wrote in message
> news:<1oEGw-2ex-1@gated-at.bofh.it>...
> 
>>On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:
>> 
>>
>>>For writes, iozone found an upper bound of about 10megs/sec, which is 
>>>abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
>>>than reads, because once the write is sent, you can forget about it. 
>>>You don't have to wait around for something to come back, and that 
>>>latency for reads can hurt performance.  The OS can also buffer writes 
>>>and reorder them in order to improve efficiency.
>>
>>It depends on the disk too. Lots of disks (specially IDE) are far slower
>>on writes than they are on reads.
> 
> 
> No. Have you verified this? If you 'dd' your swap partition from /dev/zero
> on IDE, you'll see write performance closely matches read performance, for
> drives old and new.
> 

And this sort of things is what I find with raw writes to the model of 
drive I'm using.  However, it seems that there must be some issue with 
the 3ware 7000-2 which is killing performance, or the way the Linux 
kernel is dealing with this sorta-SCSI device.

The WD1200JB should get like 30-40 megs/sec, but when being accessed 
through the 3ware, I get 10-16 megs/sec.

What could the 3ware be doing?

