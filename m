Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUBMXqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUBMXqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:46:03 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:18445 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267232AbUBMXp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:45:56 -0500
Message-ID: <402D6354.3010801@techsource.com>
Date: Fri, 13 Feb 2004 18:52:52 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Adam Radford <aradford@3WARE.com>
CC: Daniel Blueman <daniel.blueman@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: File system performance, hardware performance, ext3, 3ware RA
 ID1, etc.
References: <A1964EDB64C8094DA12D2271C04B8126F8C92C@tabby>
In-Reply-To: <A1964EDB64C8094DA12D2271C04B8126F8C92C@tabby>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adam Radford wrote:
> Perhaps you are issuing non purely sequential IO.  The card firmware does
> some 
> reodering, but at some point it will cause performance degradation.  Can you
> try 
> kernel 2.6 w/xfs? 

Not any time soon, but as I mentioned earlier, I measured 13.9 megs/sec 
when I ran this command:

     time dd if=/dev/zero of=/dev/sda2 bs=1024k count=1024

No file system was involved; I was simply writing zeros to the block 
device (swap partition with swap off).  It took 73.522 seconds to do the 
above operation.  Also, I was running in single-user mode while doing 
the test.

> 
> Also, in my experience, the 'raw io' interface doesn't issue any
> asynchronous IO.  The
> card _definately_ needs asynchronous IO posted to it or you will not get
> good results
> because you won't get all the drives busy.

With RAID1, both drives will be written with the same data.  There is no 
need to be asynchronous, since it's all completely linear and sequential 
with large data blocks.

