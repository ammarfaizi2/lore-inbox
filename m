Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277404AbRJEPFp>; Fri, 5 Oct 2001 11:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277405AbRJEPFf>; Fri, 5 Oct 2001 11:05:35 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:16528 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S277404AbRJEPFR>; Fri, 5 Oct 2001 11:05:17 -0400
Message-ID: <3BBDCAF8.6070705@antefacto.com>
Date: Fri, 05 Oct 2001 16:00:08 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alex Larsson <alexl@redhat.com>, Ulrich Drepper <drepper@cygnus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com> <20011005150144.A11810@gruyere.muc.suse.de> <3BBDB26D.2050705@antefacto.com> <20011005163807.A13524@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>>Another advantage of using the real time instead of a counter is that 
>>>you can easily merge the both values into a single 64bit value and do
>>>arithmetic on it in user space. With a generation counter you would need 
>>>to work with number pairs, which is much more complex. 
>>>
>>??
>>if (file->mtime != mtime || file->gen_count != gen_count)
>>     file_changed=1;
>>
>
>And how would you implement "newer than" and "older than" with a generation
>count that doesn't reset in a always fixed time interval (=requiring
>additional timestamps in kernel)?  
>
>-Andi
>
Well IMHO "newer than", "older than" applications have until now
done with second resolution, and that's all that's required?

Padraig.

