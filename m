Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUGZNEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUGZNEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUGZNEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:04:41 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44231 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265287AbUGZNCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:02:54 -0400
Message-ID: <410500FD.8070206@comcast.net>
Date: Mon, 26 Jul 2004 09:02:53 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no>
In-Reply-To: <20040726091004.GA32403@ii.uib.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not the same problem as I and other are describing.  There is no 
free memory when the OOM killer activates in our situation.  The kernel 
has allocated all available ram and as such, the OOM killer can't kill 
the memory hog because it's the kernel, itself.  So the OOM killer kills 
all the big apps running ...but it's to no use because the kernel just 
keeps trying to use more until the cd is completed.   After which the 
memory is still never released. 

Your thread has nothing to do with mine.



Jan-Frode Myklebust wrote:

>On Sun, Jul 25, 2004 at 09:30:38PM -0400, Ed Sweetman wrote:
>  
>
>>Indeed, i burned a smaller cd and got very similar results.  
>>    
>>
>
>Same here.. After upgrading to 2.6.8-rc2 the OOM-killer is going crazy.
>It's particularly angry at the backup client 'dsmc' (from Tivoli Storage
>Manager).  I'm monitoring its usage with 'top', and 'dsmc' is not using
>more than ~150MB in either size or RSS when the OOM-killer takes it down.
>
>The 'dsmc'-process is reporting that it's processed 2,719,000 files, and
>transfered 164.34 MB when it gets killed. i.e. it's traversed a lot of
>files, but only read about 164 MB data, so it shouldn't have filled up any
>buffer cache... 
>
>The system still has lots of free memory (~900 MB), and also 2 GB of
>unused swap. Actually there's 0K used swap..??  
>
>I've tried turning on vm.overcommit_memory, but it had no effect. Also
>tried changing the swappiness both up to 90% and down to 10%, but it
>never uses any swap.. ???
>
>BTW: I had no OOM-killer problems on 2.6.7.
>
>  
>



