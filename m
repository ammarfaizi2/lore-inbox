Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbUDRFUM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUDRFUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:20:12 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:41650 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264125AbUDRFUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:20:04 -0400
Message-ID: <40820FFF.8090906@yahoo.com.au>
Date: Sun, 18 Apr 2004 15:19:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea> <4081F809.4030606@yahoo.com.au> <20040418041748.GW743@holomorphy.com> <408206E8.5000600@yahoo.com.au> <20040418051024.GA19595@flea>
In-Reply-To: <20040418051024.GA19595@flea>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:
> On Sun, Apr 18, 2004 at 02:41:12PM +1000, Nick Piggin wrote:
> 
>>William Lee Irwin III wrote:
>>
>>>On Sun, Apr 18, 2004 at 01:37:45PM +1000, Nick Piggin wrote:
>>>
>>>
>>>>swappiness is pretty arbitrary and unfortunately it means
>>>>different things to machines with different sized memory.
>>>>Also, once you *have* gone past the reclaim_mapped threshold,
>>>>mapped pages aren't really given any preference above
>>>>unmapped pages.
>>>>I have a small patchset which splits the active list roughly
>>>>into mapped and unmapped pages. It might hopefully solve your
>>>>problem. Would you give it a try? It is pretty stable here.
>>>
>>>
>>>It would be interesting to see the results of this on Marc's system.
>>>It's a more comprehensive solution than tweaking numbers.
>>>
>>
>>Well, here is the current patch against 2.6.5-mm6. -mm is
>>different enough from -linus now that it is not 100% trivial
>>to patch (mainly the rmap and hugepages work).
> 
> 
> Will this work against 2.6.5 without -mm6?
> 

Unfortunately it won't patch easily. If this is a big
problem for you I could make you up a 2.6.5 version.

> As an aside, I've been using SVN to manage my kernel sources.  While
> I'd be thrilled to make it work, it simply doesn't seem to have the
> heavy lifting capability to handle the kernel work.  I know the
> rudiments of using BK.  What I'd like is some sort of HOWTO with
> example of common tasks for kernel development.  Know of any?
>

Well I don't do a great deal of coding or merging, but I
use Andrew Morton's patch scripts which make things very
easy for me.

Regarding bitkeeper, I have never tried it but there is
some help in Documentation/BK-usage/ which might be of
use to you.
