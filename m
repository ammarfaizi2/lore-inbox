Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVEBShu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEBShu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVEBSht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:37:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41866 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261598AbVEBShi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:37:38 -0400
Message-ID: <427650E7.2000802@tmr.com>
Date: Mon, 02 May 2005 12:10:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Morten Welinder <mwelinder@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
References: <118833cc05042908181d09bdfd@mail.gmail.com><118833cc05042908181d09bdfd@mail.gmail.com> <20050429165232.GV21897@waste.org>
In-Reply-To: <20050429165232.GV21897@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Fri, Apr 29, 2005 at 11:18:20AM -0400, Morten Welinder wrote:
> 
>>>I had three design goals. "disk space" wasn't one of them
>>
>>And, if at some point it should become an issue, it's fixable. Since
>>access to objects is fairly centralized and since they are
>>immutable, it would be quite simple to move an arbitrary selection
>>of the objects into some other storage form which could take
>>similarities between objects into account.
> 
> 
> This is not a fix, this is a band-aid. A fix is fitting all the data
> in 10 times less space without sacrificing too much performance.
> 
> 
>>So disk space and its cousin number-of-files are both when-and-if
>>problems. And not scary ones at that.
> 
> 
> But its sibling bandwidth _is_ a problem. The delta between 2.6.10 and
> 2.6.11 in git terms will be much larger than a _full kernel tarball_.
> Simply checking in patch-2.6.11 on top of 2.6.10 as a single changeset
> takes 41M. Break that into a thousand overlapping deltas (ie the way
> it is actually done) and it will be much larger.
> 
At this level of performance I would say it doesn't matter. If a full 
checkin take two minutes or three minutes doesn't concern me, because 
I'm not going to sit and watch it, I'm going to read LKML or write my 
beer blog in another window. I would care about two vs. three hours, but 
minutes are too long to wait and too short to care.

Now look at pulling 41MB over a T1 link. All of a sudden I care bigtime! 
I want very much to use my bandwidth for other things, I don't want 41MB 
added to my backup, etc. Disk space is cheap, but unless you ignore 
backups and have an OC3 or so, these numbers are large enough to be 
irritating. Not a huge issue, just one of those "piss me off every time 
I do it" things.

If there is a functional reason to use git, something Mercurial doesn't 
do, then developers will and should use git. But the associated hassles 
with large change size, rather than the absolute size, are worth 
considering.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

