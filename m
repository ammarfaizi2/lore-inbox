Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVHHQ4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVHHQ4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVHHQ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:56:14 -0400
Received: from sheffhq.office.ebuyer.com ([212.56.68.42]:9362 "EHLO
	spooge.ebuyer.com") by vger.kernel.org with ESMTP id S932094AbVHHQ4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:56:14 -0400
Message-ID: <42F78E90.7070001@ebuyer.com>
Date: Mon, 08 Aug 2005 17:55:44 +0100
From: Andy Davidson <andy@ebuyer.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050728)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: x86-64 bad pmds in 2.6.11.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr, 2005 22:49:03 -0400, Dave Jones wrote:
> On Thu, Mar 31, 2005 at 12:41:17PM +0200, Andi Kleen wrote:
>  > On Wed, Mar 30, 2005 at 04:44:55PM -0500, Dave Jones wrote:
>  > >  I arrived at the office today to find my workstation had this spew
>  > >  in its dmesg buffer..
>  > Looks like random memory corruption to me.
>  > Can you enable slab debugging etc.?
>  > >  mm/memory.c:97: bad pmd ffff81004b017438(00000038a5500a88).
>  > >  mm/memory.c:97: bad pmd ffff81004b017440(0000000000000003).
>  > >  mm/memory.c:97: bad pmd ffff81004b017448(00007ffffffff73b).
>  > >  mm/memory.c:97: bad pmd ffff81004b017450(00007ffffffff73c).
> I realised today that this happens every time X starts up for
> the first time.   I did some experiments, and found that with 2.6.12rc1
> it's gone. Either it got fixed accidentally, or its hidden now
> by one of the many changes in 4-level patches.
> I'll try and narrow this down a little more tomorrow, to see if I
> can pinpoint the exact -bk snapshot (may be tricky given they were
> broken for a while), as it'd be good to get this fixed in 2.6.11.x
> if .12 isn't going to show up any time soon.

Hi, Dave, all --

Does anyone remember if they saw any system instability at the time of 
these messages ?

I'm running 2.6.11 on an SMP Opteron box, which is exhibiting these 
notices.  The box occasionally then behaves like it would during a 
serious memory leak - the load average shoots up, the box becomes 
unresponsive, stops accepting network connections, (but memory resources 
are not entirely starved, and nor does the kernel kill any processes off.)

Then - a few minutes later, the computer returns to normal.  This seems 
to happen maybe twice a week.  Thankfully, it's not ruined my weekend 
with a phone call from support yet, but it might. ;-)

If you do remember instability at this time, which was cured with an 
upgrade, then I will schedule some down time to try this out.


-- 

Regards, Andy Davidson                                andy@ebuyer.com
Systems Administrator,                                Ebuyer (UK) Ltd
