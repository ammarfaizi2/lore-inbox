Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTKFJQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTKFJQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:16:28 -0500
Received: from smtp2.su.se ([130.237.93.212]:6622 "EHLO smtp2.su.se")
	by vger.kernel.org with ESMTP id S263467AbTKFJQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:16:21 -0500
Message-ID: <3FAA1163.8040005@it.su.se>
Date: Thu, 06 Nov 2003 10:16:19 +0100
From: =?ISO-8859-1?Q?Jerry_Lundstr=F6m?= <jerry.lundstrom@it.su.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Wee Teck Neo <slashboy84@msn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
References: <BAY4-F18tJyMmxsywxZ00005d1a@hotmail.com>
In-Reply-To: <BAY4-F18tJyMmxsywxZ00005d1a@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wee Teck Neo wrote:
> But seems like the swap space is begin used because of "insufficent" 
> free memory. I'm not sure if there is a performance slow down.
> 

no no no, this is the way linux works. Memory from programs that are not 
accessed alot are put into the swap so that the not-so-offen-used memory 
can be used by other programs or the cache to speed up everything. When 
that program later access the swaped memory it will load it up and 
remove some of the cache and after a while it will put it back into the 
swap (dont have any numbers on how long till it will but trust linux, it 
does it very good).

I wouldnt worry at all about those numbers, they are very common in 1gig 
server systems and ive worked with alot of them, even 4gig mem systems 
use the swap, thats what its for...

If you are worried about preformance with memory and such after all 
configure you systems like this:

If you use IDE have the system disk on one IDE channel and a standalone 
swap disk on another IDE channel (not master or slave way but ide0 or 
ide1). For SCSI you can just put the swap on a seperate disk.
Doing this will speed up alot of stuff since linux have 100% access to 
the swap when it needs too, it doesnt have to share the IO to the disk 
with another partition.

Otherwise Id just say, dont worry about it... Linux knows what its doing...

hope it helps...

