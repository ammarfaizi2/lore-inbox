Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266710AbUFYLuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266710AbUFYLuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 07:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266712AbUFYLuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 07:50:55 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:22423 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266710AbUFYLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 07:50:53 -0400
Message-ID: <40DC1192.7030006@comcast.net>
Date: Fri, 25 Jun 2004 07:50:42 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no> <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org>
In-Reply-To: <20040625114105.GA28892@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yeah.. Really. Here's what I do.

I have ext3 partitions, so I decided if they are different partitions, 
then I can compile my kernel with ext2 as a module and ext3 builtin.
So I do it and reboot. Panic! Reason? Cannot find filesystem for the 
root partition.
The error is in the kernel itself either way. Pick your reason.
1) ext3 is identified as ext2 on bootup.
2) There is no fallback to ext3 if ext2 is not found.

I'll check this again to be sure on a 2.6 kernel later today, but as far 
as 2.4 is concerned my kernel panics.

Regards,
David

PS. Shut up with the cheap insults. I have empirical evidence supporting 
my claim. Meaning there exists a bug somewhere.

Christoph Hellwig wrote:
> On Fri, Jun 25, 2004 at 07:30:40AM -0400, David van Hoose wrote:
> 
>>If ext2 and ext3 are different filesystems, why does my kernel panic if 
>>I include ext3 in the kernel make ext2 a module?
> 
> 
> My kernel doesn't, must be a problem in front of the computer.
> 
> 

