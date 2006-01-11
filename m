Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWAKKAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWAKKAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWAKKAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:00:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9886 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932386AbWAKKAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:00:31 -0500
Date: Wed, 11 Jan 2006 11:00:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Message-ID: <20060111100016.GC2574@elf.ucw.cz>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110170037.4a614245.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for testing and reporting - it really helps.
> 
> > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> >    reproducible (have some activity on the fs and suspend)
> 
> No significant reiser3 changes in there, so I'd be suspecting something
> else has gone haywire.

Suspend to *RAM*? That really does not do anything that should kill
the filesystems. Has it ever worked before? When? Any SATA?

> > The reiser oops seems reproducible by suspending with some dirty cache
> > (I've been able to suspend/resume cycle 3 times without reiser crashing
> > but I also didn't have big activities on that partition).
> > If really necessary I can try to reproduce it (oh, poor filesystem).
> > Other than that are ther suggestions/patches to start with?
> 
> Pavel, have you heard of anything like this??

No, never seen this before. With suspend to disk and wrong setup,
"kill my filesystem" is easy; but suspend to RAM? Best bet would be
disk driver doing something really stupid.
								Pavel
-- 
Thanks, Sharp!
