Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVKUWjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVKUWjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKUWjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:39:17 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:1232 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751157AbVKUWjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:39:15 -0500
Message-ID: <43824D20.30604@tmr.com>
Date: Mon, 21 Nov 2005 17:41:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Sandberg <lkml@metanurb.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <11b141710511210144h666d2edfi@mail.gmail.com>	 <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>	 <20051121101959.GB13927@wohnheim.fh-wedel.de>	 <20051121114654.GA25180@merlin.emma.line.org>	 <1132574831.15938.14.camel@localhost>	 <20051121131832.GB26068@merlin.emma.line.org> <1132582713.15938.22.camel@localhost>
In-Reply-To: <1132582713.15938.22.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:
> On Mon, 2005-11-21 at 14:18 +0100, Matthias Andree wrote:

>>I don't care what its name is. I am aware it is a rewrite, and that is
>>reason to be all the more chary about adopting it early. People believed
>>3.5 to be stable, too, before someone tried NFS...
> 
> nfs works fine with reiser4. you are judging reiser4 by the problems
> reiserfs had.

reiser4 will have far more problems than 3.5 without a doubt. The NFS 
problem was because it was a use which had not been properly tested, and 
that was because it had not been envisioned. You test for the cases you 
can envision, the "this is how people will use it" cases. He is judging 
by the problems of any increasingly complex software.

reiser4 has a ton of new features not found in other filesystems, and 
the developers can't begin to guess how people will use them because 
people never had these features before. When files were read, write, 
create, delete, permissions and seek, you could think of the ways people 
would use them because there were so few things you could do. Then came 
attrs, ACLs, etc, etc. All of a sudden people were doing things they 
never did before, and there were unforseen, unintended, unsupported 
interractions which went off on code paths which reminded people of "the 
less traveled way" in the poem. Developers looked at bug reports and 
asked why anyone would ever do THAT? But the bugs got fixed and ext3 
became stable.

People are going to do things the reiser4 developers didn't envision, 
they are going to run it over LVM on top of multilevel RAID using nbd as 
part of the array, on real-time, preemptable, NUMA-enabled kernels, on 
hardware platforms at best lightly tested... and reiser4 will regularly 
lose bladder control because someone has just found another "can't 
happen" or "no one would do that" path.

This isn't a criticism of reiser4, Matthias and others are just pointing 
out that once any complex capability is added, people will use it in 
unexpected ways and it will fail. So don't bother to even think that it 
matters that it's been stable for you, because you haven't begun to 
drive the wheels of it, no one person can.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
