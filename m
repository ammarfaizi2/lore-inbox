Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUEYVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUEYVBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUEYVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:01:45 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59536 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265226AbUEYVBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:01:43 -0400
Message-ID: <40B3B4C3.2050000@tmr.com>
Date: Tue, 25 May 2004 17:04:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
References: <20040525194115.GE29378@dualathlon.random> <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 25 May 2004, Andrea Arcangeli wrote:
> 
> 
>>Clearly by opening enough files or enough network sockets or enough vmas
>>or similar, you can still run out of normal zone, even on a 2G system,
>>but this is not the point or you would be shipping 4:4 on the 2G systems
>>too, no?
> 
> 
> The point is, people like to run bigger workloads on
> bigger systems. Otherwise they wouldn't bother buying
> those bigger systems.
> 

Sure, and "bigger workloads" can mean a lot of small client processes 
talking to a threaded large process, like database or news, or it can be 
huge datasets, like image or multimedia processing. Unfortunately it 
seems that these all (ab)use the VM in various ways.

x86 with lots of memory is likely to remain cost effective for years, 
not only because it not only allows more memory but needs more memory in 
most cases, but because vendors will hang on to their profit margins on 
64 bit CPUs for that long. And for uses with many small client 
processes, the advantage of 64 bits is pretty small when you have 2MB 
processes. Given a bus which allows i/o to more memory, the benefits in 
performance are really hard to see.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
