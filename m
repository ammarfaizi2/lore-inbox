Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSGIVSQ>; Tue, 9 Jul 2002 17:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSGIVSP>; Tue, 9 Jul 2002 17:18:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37021 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313767AbSGIVSO>;
	Tue, 9 Jul 2002 17:18:14 -0400
Message-ID: <3D2AF10A.1020603@us.ibm.com>
Date: Tue, 09 Jul 2002 07:19:54 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@mvista.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <20020709201703.GC27999@kroah.com>	<200207092055.g69Ktt418608@eng4.beaverton.ibm.com> 	<20020709210053.GF25360@holomorphy.com> <1026249175.1033.1178.camel@sinai>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Tue, 2002-07-09 at 14:00, William Lee Irwin III wrote:
> 
> 
>>This is an ugly aspect. But AFAICT the most that's needed to clean it
>>up is an explicit release before potentially sleeping.
> 
> 
> Yep that is all we need... remove the release_kernel_lock() and
> reacquire_kernel_lock() from schedule and do it explicitly everywhere it
> is needed.
> 
> The problem is, it is needed in a _lot_ of places.  Mostly instances
> where the lock is held across something that may implicitly sleep.

And _that_ is why I wrote the BKL debugging patch, to help find these 
places at runtime.  It may not be pretty, but it works.  I'll post it 
again if you're interested.

-- 
Dave Hansen
haveblue@us.ibm.com

