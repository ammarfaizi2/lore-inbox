Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUAEAsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUAEAsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:48:52 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:6100 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265828AbUAEAsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:48:51 -0500
Message-ID: <3FF8B470.9010301@cyberone.com.au>
Date: Mon, 05 Jan 2004 11:48:48 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Soeren Sonnenburg <kernel@nn7.de>, Lincoln Dale <ltd@cisco.com>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <1073211879.3261.6.camel@localhost> <20040104111257.GO1882@matchmail.com> <20040104111945.GA14348@alpha.home.local>
In-Reply-To: <20040104111945.GA14348@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:

>On Sun, Jan 04, 2004 at 03:12:57AM -0800, Mike Fedyk wrote:
>
>>On Sun, Jan 04, 2004 at 11:24:39AM +0100, Soeren Sonnenburg wrote:
>>
>>>[...]
>>>
>>>>Or, out of interest, an alternate scheduler?
>>>>
>>>>http://www.kerneltrap.org/~npiggin/w29p2.gz
>>>>(applies 2.6.1-rc1-mm1, please renice X to -10 or so)
>>>>
>>>Thats nothing *I* can try out as I am on the powerpc benh tree.
>>>
>>>
>>Says who?  The scheduler isn't platform specific.  Nick, do you have any per
>>arch defines in your patch?
>>
>
>I found slight changes to arch specific files, but IMHO this should not be
>the problem. But AFAIR, benh's ppc patches are somewhat complete and may
>introduce conflicts.
>

The problem is just that the mm tree is currently carrying some
intrusive (patch wise, not functionality wise) scheduler stuff
which will go to linus which is why I am working from there. So
the patch will only apply cleanly on the mm tree, but only because
of the cleanups + minor fixes. Nothing fundamental.

>
>BTW, for Nick, the patch didn't compile, I had to change sched_clock()
>definition from unsigned long long to unsigned long in
>arch/i386/kernel/timers/timer_tsc.c. Don't know if it was the right thing to
>do, but it compiles and boots.
>

Yeah thats right


