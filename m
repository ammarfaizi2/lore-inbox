Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268521AbTBWR6L>; Sun, 23 Feb 2003 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268522AbTBWR6L>; Sun, 23 Feb 2003 12:58:11 -0500
Received: from ns0.cobite.com ([208.222.80.10]:43532 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S268521AbTBWR6K>;
	Sun, 23 Feb 2003 12:58:10 -0500
Date: Sun, 23 Feb 2003 13:07:18 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Rik van Riel <riel@imladris.surriel.com>
cc: linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <Pine.LNX.4.50L.0302231325230.2206-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0302231301400.23778-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sun, 23 Feb 2003, David Mansfield wrote:
> 
> > Rik, any ideas?
> 
> You could try the patch I sent to Marc and linux-kernel
> yesterday afternoon ;)
> 

You miss my point completely.  The kernel has ALREADY chosen a task to 
kill.  I don't care to adjust the 'badness' function.  The kernel has 
already chosen a bad task.

If you read my post, the bug is that the kernel CANNOT kill that process?  
Why?  If it's really a bad process, shouldn't it be the one that gets 
killed? 

With you patch we have:

1) Kernel goes OOM
2) Kernel picks the worst task to kill using badness()
3) Kernel attempts to kill this task but fails due to some {reason|bug}.
4) Kernel now picks some other task to kill even though the 'baddest' one 
is allowed to hang out.

This is my question, and I don't see how the patch addresses it.

David



-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

