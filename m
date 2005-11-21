Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVKUXDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVKUXDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVKUXDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:03:05 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:9453 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751237AbVKUXDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:03:03 -0500
Message-ID: <438252B5.2020706@tmr.com>
Date: Mon, 21 Nov 2005 18:05:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: linux-kernel@vger.kernel.org, Diego Calleja <diegocg@gmail.com>
Subject: Re: what is our answer to ZFS?
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121124544.9e502404.diegocg@gmail.com> <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com> <200511211252.04217.rob@landley.net>
In-Reply-To: <200511211252.04217.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Monday 21 November 2005 08:19, Tarkan Erimer wrote:
> 
>>On 11/21/05, Diego Calleja <diegocg@gmail.com> wrote:
>>If It happenned, Sun or someone has port it to linux.
>>We will need some VFS changes to handle 128 bit FS as "Jörn ENGEL"
>>mentionned previous mail in this thread. Is there any plan or action
>>to make VFS handle 128 bit File Sytems like ZFS or future 128 bit
>>File Systems ? Any VFS people reply to this, please?
> 
> 
> I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.  Python says 
> 2**64 is 18446744073709551616, and that's roughly:
> 18,446,744,073,709,551,616 bytes
> 18,446,744,073,709 megs
> 18,446,744,073 gigs
> 18,446,744 terabytes
> 18,446 ...  what are those, petabytes?
> 18 Really big lumps of data we won't be using for a while yet.
> 
> And that's just 64 bits.  Keep in mind it took us around fifty years to burn 
> through the _first_ thirty two (which makes sense, since Moore's Law says we 
> need 1 more bit every 18 months).  We may go through it faster than we went 
> through the first 32 bits, but it'll last us a couple decades at least.
> 
> Now I'm not saying we won't exhaust 64 bits eventually.  Back to chemistry, it 
> takes 6.02*10^23 protons to weigh 1 gram, and that's just about 2^79, so it's 
> feasible that someday we might be able to store more than 64 bits of data per 
> gram, let alone in big room-sized clusters.   But it's not going to be for 
> years and years, and that's a design problem for Sun.

There's a more limiting problem, energy. Assuming that the energy to set 
one bit is the energy to reverse the spin of an electron, call that s. 
If you have each value of 128 bit address a single byte, then
    T = s * 8 * 2^128   and   T > B
where T is the total enargy to low level format the storage, and B is 
the energy to boil all the oceans of earth. That was in one of the 
physics magazines earlier this year. there just isn't enough energy 
usable to write that much data.
> 
> Sun is proposing it can predict what storage layout will be efficient for as 
> yet unheard of quantities of data, with unknown access patterns, at least a 
> couple decades from now.  It's also proposing that data compression and 
> checksumming are the filesystem's job.  Hands up anybody who spots 
> conflicting trends here already?  Who thinks the 128 bit requirement came 
> from marketing rather than the engineers?

Not me, if you are going larger than 64 bits you have no good reason not 
to double the size, it avoids some problems by fitting in two 64 bit 
registers nicely without truncation or extension. And we will never need 
more than 128 bits so the addressing problems are solved.
> 
> If you're worried about being able to access your data 2 or 3 decades from 
> now, you should _not_ be worried about choice of filesystem.  You should be 
> worried about making it _independent_ of what filesystem it's on.  For 
> example, none of the current journaling filesystems in Linux were available 
> 20 years ago, because fsck didn't emerge as a bottleneck until filesystem 
> sizes got really big.

I'm gradually copying backups from the 90's off DC600 tapes to CDs, 
knowing that they will require at least one more copy in my lifetime 
(hopefully).
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
