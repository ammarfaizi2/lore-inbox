Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSJUVPS>; Mon, 21 Oct 2002 17:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJUVPR>; Mon, 21 Oct 2002 17:15:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43667 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261696AbSJUVPL>; Mon, 21 Oct 2002 17:15:11 -0400
Date: Mon, 21 Oct 2002 14:16:28 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <308170000.1035234988@flay>
In-Reply-To: <3DB46DFA.DFEB2907@digeo.com>
References: <302190000.1035232837@flay> <3DB46DFA.DFEB2907@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My big NUMA box went OOM over the weekend and started killing things
>> for no good reason (2.5.43-mm2). Probably running some background
>> updatedb for locate thing, not doing any real work.
>> 
>> meminfo:
>> 
> 
> Looks like a plain dentry leak to me.  Very weird.
> 
> Did the machine recover and run normally?

Nope, kept OOMing and killing everything .
 
> Was it possible to force the dcache to shrink? (a cat /dev/hda1
> would do that nicely)

Well, I didn't try that, but even looking at man pages got oom killed,
so I guess not ... were you looking at the cat /dev/hda1 to fill pagecache
or something? I have 16Gb of highmem (pretty much all ununsed) so 
presumably that'd fill the highmem first (pagecache?)

> Is it reproducible?

Will try again. Presumably "find /" should do it? ;-)

M.

