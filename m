Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUKOQ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUKOQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUKOQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:59:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38615 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261638AbUKOQ7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:59:41 -0500
Date: Mon, 15 Nov 2004 19:01:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       unlisted-recipients: no@chiara.elte.hu, To-header@chiara.elte.hu,
       on@chiara.elte.hu, "input <"@chiara.elte.hu, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	;
			^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	;
			^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH] Real-Time Preemption, another mutex implementation.
Message-ID: <20041115180136.GA8088@elte.hu>
References: <200411131729.AA09315@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411131729.AA09315@da410.ifa.au.dk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> The main reason for this speedup is that I only keep the highest
> priority waiter on each mutex held by task on the list corresponding
> to task->pi_waiters and I keep the list sorted.

interesting, but it would be nice to see some actual benchmark results
as well. You made the 'task blocks' case faster at the expense of making
the (more common) 'task doesnt block' case slower. Which one wins
depends on benchmarks.

	Ingo
