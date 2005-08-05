Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVHEPZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVHEPZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVHEPXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:23:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36006 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261779AbVHEPWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:22:01 -0400
Date: Fri, 5 Aug 2005 17:22:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Message-ID: <20050805152245.GA12650@elte.hu>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050804152858.2ef2d72b.akpm@osdl.org> <20050805104819.GA20278@elte.hu> <200508051626.56910.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508051626.56910.dominik.karall@gmx.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Karall <dominik.karall@gmx.net> wrote:

> BUG: mono[10011] exited with nonzero preempt_count 1!
> ---------------------------
> | preempt count: 00000001 ]
> | 1 level deep critical section nesting:
> ----------------------------------------
> .. [<ffffffff803f791e>] .... _spin_lock+0xe/0x70
> .....[<0000000000000000>] ..   ( <= 0x0)
> 
> If there is anything I should test, let me know!

please enable CONFIG_FRAME_POINTERS!

we now know that it's a spin_lock reference that got leaked, but we dont 
(yet) know the parent.

	Ingo
