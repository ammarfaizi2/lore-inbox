Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbVAFWfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbVAFWfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVAFWdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:33:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18395 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263142AbVAFWbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:31:15 -0500
Message-ID: <41DDBC52.4020801@tmr.com>
Date: Thu, 06 Jan 2005 17:31:46 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <4d8e3fd30501060603247e955a@mail.gmail.com><4d8e3fd30501060603247e955a@mail.gmail.com> <20050106193214.GK3096@stusta.de>
In-Reply-To: <20050106193214.GK3096@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jan 06, 2005 at 03:03:26PM +0100, Paolo Ciarrocchi wrote:
> 
>>What's wrong in keeping the release management as is now plus
>>introducing a 2.6.X.Y series of kernels ?
>>
>>In short:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109882220123966&w=2
> 
> 
> Currently (2.6.10), there would have been 11 such branches.
> 
> If a security vulnerability was found today, this meant backporting and 
> applying the patch to 11 different kernel versions, the oldest one being 
> more than one year old.
> 
> With more 2.6 versions, there would be even more branches, and the 
> oldest ones becoming more and more different from the current codebase.
> 
> You could at some point start dropping the oldest branches, but this 
> would mean a migration to a more recent branch for all users of this 
> branch.
> 
> OTOH, if you migrated relatively late at 2.4.17 to the 2.4 branch, this 
> branch is still actively maintained today, more than 3 years later.

I don't think that's what he meant (I hope not) and I know it's not what 
I had in mind. What I was suggesting is that until 2.6.11 comes out, all 
patches which are fixes (existing feature doesn't work, oops, security 
issues, or other "unusable with the problem triggered" cases) would go 
into 2.6.10.N, where N would be a small number unless we had another 100 
day release cycle.

This wouldn't be a blank check to maintain a version forever, and since 
the patch from 2.6.10 to 2.6.11 will be against a 2.6.10 base there will 
not be a lot of rediffing beyond what's needed if someone submits a 
patch against -mm or -bk or whatever. It's not zero work, but it's small 
work.

When 2.6.11 came out, the 2.6.10.N effort would stop, or perhaps 
continue for a short time in the unlikely event that some huge security 
hole was found within the first week or so after 2.6.11. That seems to 
happen at most a few times a year. In general once 2.6.N+1 is out, 
2.6.N.x is frozen.

Since the mechanism is already in place to generate -bk versions against 
both the base and previous -bk version, I don't see any reason why both 
can't be available.

Unless I'm missing something this would involve only a small amount of 
work which wouldn't be done anyway, and would provide a bugfix path 
which people could use with a high probability of unwanted side effects.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
