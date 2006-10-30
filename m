Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWJ3ChY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWJ3ChY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 21:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWJ3ChY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 21:37:24 -0500
Received: from main.gmane.org ([80.91.229.2]:15020 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751921AbWJ3ChX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 21:37:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: First benchmarks of the ext4 file system
Date: Sun, 29 Oct 2006 21:37:12 -0500
Message-ID: <45456558.5070600@tmr.com>
References: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>	 <20061023020731.GA486@thunk.org> <ceccffee0610230832l4eb76b0dvd1c4c275ae462d3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
In-Reply-To: <ceccffee0610230832l4eb76b0dvd1c4c275ae462d3d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Portal wrote:
> On 10/23/06, Theodore Tso <tytso@mit.edu> wrote:
>> On Sun, Oct 22, 2006 at 01:57:36AM +0200, Linux Portal wrote:
>> > ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
>> > to extents and delayed allocation. On other tests it is either
>> > slightly faster or slightly slower. reiser4 comes as a nice surprise,
>> > winning few benchmarks. Both are very stable, no errors during
>> > testing.
>>
>> As Andrew has already pointed out, we don't have delayed allocation
>> merged in into the -mm tree yet.
> 
> OK.
> 
>> If you have the
>> time/energy/interest, a very useful thing that would very much help
>> the filesystem developers of all filesystems to do would be to
>> automated your tesitng enough that you can do these tests on a
>> frequent basis, both to track regressions caused by changes in other
>> parts of the kernel, as well we to see what happens as various bits of
>> functionality get added to the filesystem.  This of course can become
>> an arbitrarily a huge amount of work, as you add more filesystems and
>> benchmarks, but it's the sort of thing which is incredibly useful
>> especially if the hardware is held constant across a large number of
>> filesystems, workloads/benchmarks, and kernel versions.
>>
> 
> I agree completely. That was my original idea, to prepare some setup for
> thorough testing, but I soon discovered that would really be a huge 
> project,
> because of so many parameters involved.

I think the memory size is likely to make a substantial difference as 
well, particularly at the small end where caching space gets limited.

I agree, as the test gets better by adding parameters it gets slower, 
takes more human time, and the results get harder to understand. 
Particularly when the answer to most of the "which is faster" questions 
becomes "it depends."

I ran into this with resp2 (application response after a sleep in a 
loaded system), to the point where I stopped working on the project.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

