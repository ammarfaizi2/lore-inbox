Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVHNBiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVHNBiw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVHNBiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 21:38:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65249 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S932300AbVHNBiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 21:38:51 -0400
Date: Sun, 14 Aug 2005 03:38:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] [patch 0/39] remap_file_pages protection support, try 2
Message-ID: <20050814013849.GA23795@elte.hu>
References: <200508122033.06385.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508122033.06385.blaisorblade@yahoo.it>
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


* Blaisorblade <blaisorblade@yahoo.it> wrote:

> Ok, I've been working for the past two weeks learning well the Linux 
> VM, understanding the Ingo's remap_file_pages protection support and 
> its various weakness (due to lack of time on his part), and splitting 
> and finishing it.
> 
> Here follow a series of 39 _little_ patches against the git-commit-id 
> 889371f61fd5bb914d0331268f12432590cf7e85, which means between 
> 2.6.13-rc4 and -rc5.
> 
> Actually, the first 7 ones are unrelated trivial cleanups which 
> somehow get in the way on this work and that can probably be merged 
> even now (many are just comment fixes).
> 
> Since I was a VM newbie until two weeks ago, I've separated my changes 
> into many little patches.

hi. Great work! I'm wondering about this comment in 
rfp-fix-unmap-linear.patch:

> Additionally, add a missing TLB flush in both locations. However, 
> there'is some excess of flushes in these functions.

excess TLB flushes one of the reasons of bad UML performance, so you 
should really review them and not do spurious TLB flushes.

	Ingo
