Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTH2PwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbTH2PwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:52:15 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:26259 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261306AbTH2PwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:52:08 -0400
Message-ID: <3F4F76A5.6020000@wmich.edu>
Date: Fri, 29 Aug 2003 11:52:05 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu> <m3vfsgpj8b.fsf@bzzz.home.net>
In-Reply-To: <m3vfsgpj8b.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>>Ed Sweetman (ES) writes:
> 
> 
>  ES> If it's the same as test2 then i've already tried it.  I got no
>  ES> performance gains as far as dbench is concerned.  Perhaps my block
>  ES> size is not optimal on that partition for extents.  Either way it
>  ES> seemed to make the kernel unstable and i've been trying to fix things
>  ES> since mid-day yesterday.  Been getting very strange problems, no error
>  ES> messages are reported or anything like that.
> 
> I still use -test2, because -test4 detects my scsi hdds in another order
> than -test2. last time I sent rediff against -test4. what kind of problem
> did you see?
> 

in the kernels that would boot (for some reason test4's videodev driver 
is borked so i used the mm patchset) passed the serio drivers, init was 
unable to be found, no matter what even though it mounted the root fs 
and the root fs is not as far as i can tell when booting on older 
kernels, corrupted.   I'm writing now in mozilla from the very system 
but with extents turned off.  I'm somewhat afraid though that even 
though i didn't mount the partitions with the extents option, that the 
patch may still be having an adverse effect.  Right now things seem 
pretty stable but last night apt was hanging while generating locales 
reproducably causing the entire kernel to lose the ability to do 
anything to the fs. This was all being tested on test3-mm1.  I am aware 
that mm does have some patches to ext3 that aren't in the main kernel i 
believe. perhaps the xattr stuff is conflicting in some way?  I really 
have no way of testing the linus tree directly because the drivers i use 
wont compile.


All in all though, when it was enabled, i saw really no difference from 
when it was not enabled. dbench 16 gave me ~140MB/sec either way. 
md5summing large files resulted in equal performance as well.  I got 
nothing even close to the kind of performance increases you showed in 
the first mail.

