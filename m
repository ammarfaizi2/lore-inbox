Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWEIOiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWEIOiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWEIOiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:38:09 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:39885 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750823AbWEIOiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:38:07 -0400
Message-ID: <4460A91D.3030701@tmr.com>
Date: Tue, 09 May 2006 10:37:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>,
       Erik Mouw <erik@harddisk-recovery.com>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <20060508111345.GA1875@harddisk-recovery.com> <1147087356.2888.9.camel@laptopd505.fenrus.org> <20060508112831.GA14206@flint.arm.linux.org.uk>
In-Reply-To: <20060508112831.GA14206@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, May 08, 2006 at 01:22:36PM +0200, Arjan van de Ven wrote:
>> On Mon, 2006-05-08 at 13:13 +0200, Erik Mouw wrote:
>>> On Sun, May 07, 2006 at 09:50:39AM -0700, Andrew Morton wrote:
>>>> This is probably because the number of pdflush threads slowly grows to its
>>>> maximum.  This is bogus, and we seem to have broken it sometime in the past
>>>> few releases.  I need to find a few quality hours to get in there and fix
>>>> it, but they're rare :(
>>>>
>>>> It's pretty harmless though.  The "load average" thing just means that the
>>>> extra pdflush threads are twiddling thumbs waiting on some disk I/O -
>>>> they'll later exit and clean themselves up.  They won't be consuming
>>>> significant resources.
>>> Not completely harmless. Some daemons (sendmail, exim) use the load
>>> average to decide if they will allow more work.
>> and those need to be fixed most likely ;)
> 
> Why do you think that?  exim uses the load average to work out whether
> it's a good idea to spawn more copies of itself, and increase the load
> on the machine.
> 
> Unfortunately though, under 2.6 kernels, the load average seems to be
> a meaningless indication of how busy the system is from that point of
> view.
> 
> Having a single CPU machine with a load average of 150 and still feel
> very interactive at the shell is extremely counter-intuitive.
> 
The things which is important is runable (as in want the CPU now)
processes. I've seen the L.A. that high on other systems which were
running fine, AIX and OpenDesktop to name two. It's not just a Linux thing.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

