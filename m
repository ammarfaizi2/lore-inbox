Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270466AbRHWVVr>; Thu, 23 Aug 2001 17:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270469AbRHWVVh>; Thu, 23 Aug 2001 17:21:37 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:23317 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S270466AbRHWVVV>; Thu, 23 Aug 2001 17:21:21 -0400
Message-ID: <3B8573D0.1000904@humboldt.co.uk>
Date: Thu, 23 Aug 2001 22:21:20 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk> <3B83FB3F.A0BDC056@zip.com.au> <3B853BE6.3010703@humboldt.co.uk> <3B854186.F0C00E3C@zip.com.au> <3B8556B6.7040700@humboldt.co.uk> <3B855C62.85BC16E7@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ah.  Now I'm with you.  Yes, we need a better cleanup facility
> to handle this.
> 
> We can sort-of fudge it with commit_write():
[snip]
> Which is OK for mid-file blocks, but will cause i_size to be extended
> at eof, which probably isn't too bad.  Needs more thought.

That certainly stops it happening. Does anybody think that extending 
i_size in this particular corner case is harmful?

As Alan said, the bug is the file system committing metadata too early, 
and I suspect that ext2 is not the only culprit.

-- 
Adrian Cox   http://www.humboldt.co.uk/

