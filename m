Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSCDRt7>; Mon, 4 Mar 2002 12:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCDRt5>; Mon, 4 Mar 2002 12:49:57 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:32421 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292629AbSCDRtQ>; Mon, 4 Mar 2002 12:49:16 -0500
Date: Mon, 04 Mar 2002 12:48:44 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
Message-ID: <1225610000.1015264124@tiny>
In-Reply-To: <200203041735.g24HZOu09098@localhost.localdomain>
In-Reply-To: <200203041735.g24HZOu09098@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 04, 2002 11:35:24 AM -0600 James Bottomley <James.Bottomley@steeleye.com> wrote:

> sct@redhat.com said:
>> Generally, that may be true but it's irrelevant.  Internally, the fs
>> may keep transactions as independent, but as soon as IO is scheduled,
>> those transactions become serialised.  Given that pure sequential IO
>> is so much more efficient than random IO, we usually expect
>> performance to be improved, not degraded, by such serialisation. 
> 
> This is the part I'm struggling with.  Even without error handling and certain 
> other changes that would have to be made to give guaranteed integrity to the 
> tag ordering, Chris' patch is a very reasonable experimental model of how an 
> optimal system for implementing write barriers via ordered tags would work; 
> yet when he benchmarks, he sees a performance decrease.
> 

Actually most tests I've done show no change at all.  So far, only
lots of O_SYNC writes stress the log enough to show a performance
difference, about 10% faster with tags on.

> I can dismiss his results as being due to firmware problems with his drives 
> making them behave non-optimally for ordered tags, but I really would like to 
> see evidence that someone somewhere acutally sees a performance boost with 
> Chris' patch.

So would I ;-)

> 
> Have there been any published comparisons of a write barrier implementation 
> verses something like the McKusick soft update idea, or even just 
> multi-threaded back end completion of the transactions?

Sorry, what do you mean by multi-threaded back end completion of the
transaction? 

-chris

