Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277367AbRJEMuJ>; Fri, 5 Oct 2001 08:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277368AbRJEMuA>; Fri, 5 Oct 2001 08:50:00 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:30091 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S277367AbRJEMtq>; Fri, 5 Oct 2001 08:49:46 -0400
Message-ID: <3BBDAB24.7000909@antefacto.com>
Date: Fri, 05 Oct 2001 13:44:20 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alex Larsson <alexl@redhat.com>, Ulrich Drepper <drepper@cygnus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Wed, Oct 03, 2001 at 11:15:04AM -0400, Alex Larsson wrote:
>
>>Is a nanoseconds field the right choice though? In reality you might not 
>>have a nanosecond resolution timer, so you would miss changes that appear
>>on shorter timescale than the timer resolution. Wouldn't a generation 
>>counter, increased when ctime was updated, be a better solution?
>>
>
>Near any CPU has a cycle counter builtin now, which gives you ns like
>resolution. In theory you could still get collisions on MP systems, 
>but window is small enough that it can be ignored in practice.
>
>-Andi
>
But the point is you, only ever would want nano second resolution to make
sure you notice all changes to a file. A more general (and much simpler)
solution would be to gen_count++ every time a file's modified. What other
applications would require better than second resolution on files?

Padraig.

