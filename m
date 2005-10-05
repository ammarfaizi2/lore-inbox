Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVJEVVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVJEVVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJEVVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:21:33 -0400
Received: from postman.ripe.net ([193.0.0.199]:209 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S1030314AbVJEVVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:21:32 -0400
Message-ID: <434443D9.3010501@colitti.com>
Date: Wed, 05 Oct 2005 23:21:29 +0200
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz>
In-Reply-To: <20051005084141.GB22034@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_00
X-RIPE-Spam-Status: N 0.071890 / -5.9
X-RIPE-Signature: d5eb86812671894d328a0a59a10d981f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> Pavel, at the PM summit, we agreed to work toward getting Suspend2
>> merged. I've been working since then on cleaning up the code, splitting
>> the patches up nicely and so on. In the meantime, you seem to have gone
>> off on a completely different tangent, going right against what we
>> agreed then.
> Sorry about that. At pm summit, I did not know if uswsusp was
> feasible. Now I'm pretty sure it is (code works and is stable).

Ok, excuse me for butting in.

I would just like to give the point of view of a user.

I have been using suspend2 probably at least once a day for about a year 
now, and I love it. I have had zero cases of data corruption, and it's 
fast, effective, and reliable. I can't say the same about the in-kernel 
swsusp. When I tried it (once), a few months ago:

- It was dog slow because it doesn't use compression
- Even though it's dog slow, it doesn't save all RAM
   - Therefore the machine is dog slow after resume
- It doesn't have a decent UI
- There is no way to abort suspend once it's started. (Whatever others
   may say, this /is/ useful, especially when you've forgotten something
   and you're in a hurry and don't have two more minutes to waste waiting
   for a suspend/resume cycle.)

These points /do/ matter to users: after all, if we all had time to 
waste we'd never use suspend or S3, we'd just reboot all the time...

I have been waiting for swsusp2 to be merged ever since I started  using 
it. When I read about the discussion at the PM summit, I hoped that this 
would finally happen. Now I see that it's not, and instead work is going 
to continue on what is - or at least seemed to be when I tried it - an 
inferior implementation. From my point of view as a user, this seems 
silly. There may be all the technical reasons in the world to dislike 
suspend2; on these, I defer to everyone else, since I'm no kernel 
hacker. But from the point of view of a user, well, suspend2 is much better.

So, instead of working on getting swsusp, which is still far behind in 
terms of functionality, up to the level of suspend2, why not work 
together on merging swsusp2, which is fast, stable and provides what 
users want and need?


Cheers,
Lorenzo

-- 
http://www.colitti.com/lorenzo/
