Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJJOfE>; Thu, 10 Oct 2002 10:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJJOfE>; Thu, 10 Oct 2002 10:35:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14609 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261609AbSJJOfD>;
	Thu, 10 Oct 2002 10:35:03 -0400
Message-ID: <3DA59159.3070901@pobox.com>
Date: Thu, 10 Oct 2002 10:40:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A simple request (was Re: boring BK stats)
References: <20021009.163920.85414652.wlandry@ucsd.edu> <3DA58B60.1010101@pobox.com> <20021010072818.F27122@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
>>The laptop has 200MB RAM, and mozilla and a ton of xterms loaded.  IDE 
>>drives w/ Intel PIIX4 controller.  The Dual Athlon has 512MB RAM, and I 
>>forget what kind of IDE controller -- I think AMD.  IDE drives as well.
>>
>>BitKeeper must scan the entire tree when doing a checkin or checkout, so 
>>that is impossible to optimize at the SCM level without compromising 
>>features...  if your source tree takes up ~190MB on disk, you have 200MB 
>>of RAM total, and you need to sequentially scan the entire thing, there 
>>is nothing that can be done at either the OS or app level... You're just 
>>screwed.  Things are extremely fast on the Dual Athlon because the 
>>entire tree is in RAM.
> 
> 
> In low memory situations you really want to run the tree compressed.  
> ON a fast machine do a "bk -r admin -Z" and then clone that onto your
> laptop.  I think that will drop the tree to about 145MB which will
> help, maybe.  I suspect that you use enough of the rest of your 200MB
> that it still won't fit.

Yeah, I don't think that will help at all, given that X and KDE and all 
its acoutrements are loaded...  I would rather run uncompressed anyway :)


> For the checkouts, always do a "bk -r get -S" the -S doesn't check out the
> file again if it is already there.  We could make that the default but
> it is an interface change.  A fairly minor one though.

I do "bk -r co -Sq", is the above faster than that?


> We've got some other fixes in the pipeline for the checkin and integrity
> check pass.
> 
> There is only so much we can do when you are trying to cram 10 pounds of
> crap in a 5 pound bag :(

indeed :)  That's why I keep repeating that it's not BK's fault, and 
keep pointing out that my Dual Athlon with plenty of RAM does multiple 
simultaneous checks/checkins quite rapidly.

	Jeff



