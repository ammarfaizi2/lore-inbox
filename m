Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264825AbUEKQZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbUEKQZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUEKQZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:25:47 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:27627 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264825AbUEKQZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:25:08 -0400
Message-ID: <40A0FF29.1060006@sgi.com>
Date: Tue, 11 May 2004 11:28:25 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Silviu Marin-Caea <silviu@genesys.ro>, linux-kernel@vger.kernel.org
Subject: Re: dynamic allocation of swap disk space
References: <fa.n6pggn5.84en31@ifi.uio.no> <40A0EFC0.1040609@sgi.com> <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405111552.i4BFqFMN000112@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

John Bradford wrote:
>
> 
> Not necessarily.  Increasing swap can allow more physical RAM to be used for
> caching data from disk.
> 
> Imagine a system with limited physical RAM, and limited swap space, running a
> process which causes a lot of filesystem activity on the same physical disk
> as is being used for swap.  If the total RAM, both physical and swap is almost
> completely full, increasing the swap space may allow some data from physical
> RAM to be swapped out, in favour of caching filesystem data from the disk.

Hmmm... Lets see, we have a program (or set of programs) in memory that is 
thrashing, i. e. it is page faulting at a rate that is higher than the vm 
system can supply pages, so it is spending its time waiting for pages and the 
disk subsystem is busy.  Now, if we increase the amount of data cached from 
disk, without increasing main memory, we've decreased the amount of memory 
available to the thrashing program, perhaps making its problems worse?

Well, I guess all this shows is that with the vm subsystem, speculation is 
often useless, one has to fire up the box with a carefully constructed 
workload and see what happens.

> 
> Without knowing more details of the original poster's machine, it's difficult
> to give specific advice about how to solve the problem.
>

I certainly agree with that.  Time for this thread to die, I think.  :-)

Cheers.

> John.
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

