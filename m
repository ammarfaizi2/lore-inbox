Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbTBWUVP>; Sun, 23 Feb 2003 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268927AbTBWUVP>; Sun, 23 Feb 2003 15:21:15 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:20397 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268922AbTBWUVN> convert rfc822-to-8bit; Sun, 23 Feb 2003 15:21:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Rik van Riel <riel@imladris.surriel.com>
Subject: Re: oom killer and its superior braindamage in 2.4
Date: Sun, 23 Feb 2003 21:29:28 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       David Mansfield <lkml@dm.cobite.com>
References: <200302222025.48129.m.c.p@wolk-project.de> <200302231833.05944.m.c.p@wolk-project.de> <Pine.LNX.4.50L.0302231715090.2206-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.50L.0302231715090.2206-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302232129.28595.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 February 2003 21:18, Rik van Riel wrote:

Hi Rik,

> It'd be interesting to know where these processes are spending
> their CPU time and why they're not catching their signals.
I'll look into it again when I do the next run.

> > Sysrq-i gave me the chance to get out of the OOM killing process and
> > only kernel threads were left + getty's so I was able to log in again.
> Strange, so sysrq-i manages to kill the processes, but the OOM
> killer doesn't kill the processes ?
yep, so it is.

> This is very suspect because the OOM killer uses force_sig in
> the same way the sysrq-i handler does...
indeed. Well, sysrq-i need about 5 seconds to give me my getty back.

Anyway, your patch should go into -BK. Your patch does _not_ introduce this 
behaviour, it's present even w/o your patch but your approach makes things 
better :)

ciao, Marc
