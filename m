Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSGHOwm>; Mon, 8 Jul 2002 10:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSGHOwm>; Mon, 8 Jul 2002 10:52:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7354 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316951AbSGHOwl>;
	Mon, 8 Jul 2002 10:52:41 -0400
Message-ID: <3D29A775.2090707@us.ibm.com>
Date: Mon, 08 Jul 2002 07:53:41 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Alexander Viro <viro@math.psu.edu>, Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <3D28FE72.1080603@us.ibm.com> <Pine.GSO.4.21.0207072258350.24900-100000@weyl.math.psu.edu> <20020708133321.S27706@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sun, Jul 07, 2002 at 11:06:32PM -0400, Alexander Viro wrote:
> 
>>The thing being, if you are already contended you are playing "I'll release
>>CPU now" vs. "I'll spin in hope that contender will go away right now".
>>
>>IOW, it's a win only if you get contention often and for short intervals.
>>Which is a very good indication that something is rotten with your locking
>>scheme.  Like, say it, having lost the control over the amount of locks
>>as the result of brainde^Woverenthusiastic belief that fine-grained ==
>>good.  With everything that follows from that...
> 
> So let's get some numbers.  It really shouldn't be hard to make our
> current semaphores spin a little before they sleep.  If we get some
> numbers showing it does help then either we need this change in mainline
> or we need to fix our locking.

Sounds good to me.  Do you have any code, or a workload that you know 
will trigger it?  I have a feeling that Specweb will probably show 
this behavior, but I want something simpler.

-- 
Dave Hansen
haveblue@us.ibm.com

