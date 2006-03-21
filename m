Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWCUTPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWCUTPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWCUTPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:15:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26339 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965072AbWCUTPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:15:45 -0500
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org>
	 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
	 <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
	 <1142962995.4749.39.camel@praia>
	 <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
	 <1142965478.4749.58.camel@praia>
	 <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 21 Mar 2006 16:15:37 -0300
Message-Id: <1142968537.4749.96.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Em Ter, 2006-03-21 às 10:42 -0800, Linus Torvalds escreveu:
> 
> On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
> > 
> > What is sad is that I can't determinate the root cause of this breakage,
> > but it seemed to be associated with merging handling at stg or git.
> 
> Note that the bad commit has a totally different commit message from any 
> of your other merges. It was this one:
> 
> 	diff-tree e338b736f1aee59b757130ffdc778538b7db18d6 (from cb31c70cdf1ac7034bed5f83d543f4888c39888a)
> 	Author:     Mauro Carvalho Chehab <mchehab@infradead.org>
> 	AuthorDate: Fri Mar 10 01:30:04 2006 -0300
> 	Commit:     Mauro Carvalho Chehab <mchehab@infradead.org>
> 	CommitDate: Fri Mar 10 01:30:04 2006 -0300
> 
> 	    Merging Linus tree
> 
> 	:100644 100644 be5ae600f5337dbb14daa8d4cace110486e14f79 81bc51369f59a413108fd8b150c3090541ba49f8 M      Documentation/feature-removal-schedule.txt
> 	:100644 100644 75205391b335f85c9b8a599d0d3b4c0dd1a8b41b fc99075e0af47f0b73a2ae2dfb7d19920c604dea M      Documentation/kernel-parameters.txt
> 	:100644 100644 9006063e73691da7b68449955a135f7c9317e2cd da677f829f7689966bf09aeda6d89fc4b6a876d1 M      arch/alpha/kernel/irq.c
> 	...
> 
> ie it does _not_ fit the pattern of your other merges.

Weird, I can't see all those stuff here. It shows something like
(running from master copy at kernel.org):

$ git-show e338b736f1aee59b757130ffdc778538b7db18d6
diff-tree e338b736f1aee59b757130ffdc778538b7db18d6 (from
cb31c70cdf1ac7034bed5f83d543f4888c39888a)
Author: Mauro Carvalho Chehab <mchehab@infradead.org>
Date:   Fri Mar 10 01:30:04 2006 -0300

    Merging Linus tree

diff --git a/Documentation/feature-removal-schedule.txt
b/Documentation/feature-removal-schedule.txt
...

So, after the merging message, I have a normal diff with:

 179 files changed, 1274 insertions(+), 785 deletions(-)

Seeming all perfect from my knowledge about git.

I don't want to bother you more with this subject. If you don't mind,
I'll make a brief from what we've discussed here, and I'll open a thread
at git mailing list c/c you. 

>From my part, I'm not comfortable with a weird situation that generated
such bad merging, so, I'm very concerned about it. I'm here to
contribute, not to disturb with bad patches or bad merges. If this issue
is not addressed, it may generate troubles in the future. 

> 		Linus
Cheers, 
Mauro.

