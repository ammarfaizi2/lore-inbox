Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTBPTJK>; Sun, 16 Feb 2003 14:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTBPTJK>; Sun, 16 Feb 2003 14:09:10 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:12735 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267334AbTBPTJK>;
	Sun, 16 Feb 2003 14:09:10 -0500
Message-ID: <3E4FE416.5040604@colorfullife.com>
Date: Sun, 16 Feb 2003 20:18:46 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
References: <Pine.LNX.4.44.0302161017500.2619-100000@home.transmeta.com> <26480000.1045422382@[10.10.2.4]>
In-Reply-To: <26480000.1045422382@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>Well, I did the stupid safe thing, and it hangs the box once we get up to 
>a load of 32 with SDET. Below is what I did, the only other issue I can
>see in here is that task_mem takes mm->mmap_sem which is now nested inside
>the task_lock inside tasklist_lock ... but I can't see anywhere that's a
>problem from a quick search
>  
>
task_lock is actually &spin_lock(tsk->alloc_lock); mmap_sem is a 
semaphore. Nesting means deadlock.

--
    Manfred

