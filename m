Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUIOWRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUIOWRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUIOWPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:15:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58837 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267614AbUIOVpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:45:51 -0400
Date: Wed, 15 Sep 2004 23:47:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040915214706.GB30140@elte.hu>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915144523.0fec2070.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
> >
> > William spotted this stray bit, LOCK_SECTION isn't used anymore on x86_64. 
> 
> btw, Ingo and I were scratching heads over an x86_64 oops in curent -linus
> trees.
> 
> If you enable profiling and frame pointers, profile_pc() goes splat
> dereferencing the `regs' argument when it decides that the pc refers to a
> lock section.  Ingo said `regs' had a value of 0x2, iirc.  Consider this a
> bug report ;)

'regs->rbp' had the wrong value i think.

	Ingo
