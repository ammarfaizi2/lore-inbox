Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbRG0PCS>; Fri, 27 Jul 2001 11:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbRG0PCL>; Fri, 27 Jul 2001 11:02:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19472 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267317AbRG0PCC>; Fri, 27 Jul 2001 11:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 17:06:46 +0200
X-Mailer: KMail [version 1.2]
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int>
In-Reply-To: <0107270818120A.06707@widmers.oce.srci.oce.int>
MIME-Version: 1.0
Message-Id: <0107271706460G.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 16:18, Joshua Schmidlkofer wrote:
> I've almost quit using reiser, because everytime I have a power
> outage, the last 2 or three files that I've editted, even ones that I
> haven't touched in a while, will usually be hopelessly corrupted.

My early flush patch will fix this, or at least it will if I get 
together with the ReiserFS guys and figure out how to integrate their 
flushing mechanism with the standard bdflush.  Or they could 
incorporate the ideas from my early flush in their own flush daemon, 
though generalizing the standard flush would have more value in the 
long run.

> The '<file>~' that Emacs makes is usually fine though.

Because it's "created" by a rename.

[...]
>     Once,  I lost power in on my SQL box, [it was blessedly during a
> period of no use.]  I had to rebuild all the indexes.  Not  only
> THAT, but what happens to that box if I lose power whilst in the
> middle of operations? I am working on the migration plan to move that
> to XFS because of these concerns. [However, I am doing a better job
> of testing with XFS first.]

Help is on its way.  You can try full-data journalling with the journal 
on NVRAM or on a separate disk.  You can also wait for me to get a 
usable version of Tux2 working.  It's progressed a little slowly 
because of frequent side trips ;-)  But hopefully I'll be able to do 
something about that soon.

Which flavor of SQL are you using?  Are the indices in separate files?  
(Sounds like they are.)

>   I think that Reiser is cool, and has neat ideology, but I am
> un-nerved by this behaviour.

I think it's not hard to fix.

--
Daniel
