Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267281AbUBMXHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267292AbUBMXHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:07:25 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:58378 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267281AbUBMXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:07:19 -0500
Message-ID: <402D5A46.4090409@techsource.com>
Date: Fri, 13 Feb 2004 18:14:14 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1,
 etc.
References: <402C0D0F.6090203@techsource.com> <20040213055350.GG29363@alpha.home.local> <402D235F.7030401@techsource.com> <20040213223949.GA13937@alpha.home.local>
In-Reply-To: <20040213223949.GA13937@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:
> On Fri, Feb 13, 2004 at 02:19:59PM -0500, Timothy Miller wrote:
>  
> 
>>Assuming that the "buffered" speeds are being buffered by the OS, we'll 
>>ignore those.  I am therefore observing that the writes to a single 
>>drive are 3 to 4 times faster than they are through the RAID controller, 
>>even with the 3ware write cache ON.
>>
>>Does that make any sense?
> 
> 
> Well, it reminds me a disk I had problems with several years ago. It had
> a few defects in the FAT area, which were relocated at the end. Performance
> was terrible since the head had to move constantly. It took ages to install
> Win31 on it, so it finally was returned to the vendor. But in your case it
> seems a little bit different since you experience slow writes anywhere on
> the medium. Would it be possible that your controller does something like
> read-modify-write because of too big chunk size ?
> 

I'm getting 10-15 meg/sec even with the largest block sizes.  With dd, I 
  set the block size to 1 megabyte, so there's no chance that the block 
being written is too small or that the disk block is too big.

Also, it's a RAID1.


