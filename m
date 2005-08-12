Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVHLSgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVHLSgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVHLSgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:36:15 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:54261 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750907AbVHLSgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:36:15 -0400
Date: Fri, 12 Aug 2005 14:35:44 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the  difference
 between /dev/km
In-Reply-To: <200508121422_MC3-1-A70F-D742@compuserve.com>
Message-ID: <Pine.LNX.4.58.0508121434001.10689@localhost.localdomain>
References: <200508121422_MC3-1-A70F-D742@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Aug 2005, Chuck Ebbert wrote:
>  Even with Steven's patch applied, root cannot read from /dev/kmem with the
> following program, which works on 2.6.9.  "Invalid argument" means that the
> "fd is attached to an object that is unsuitable for reading."
>

Yeah, I noticed this too. But my programs were only mmaping kmem, and not
reading it, so I didn't bother to fix that.  When I get a chance, I could
also look into that too.  But I guess the next thing to do is send in a
patch that makes kmem a config option, with the default off.

-- Steve

