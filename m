Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269302AbUIYKRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269302AbUIYKRI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 06:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269304AbUIYKRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 06:17:07 -0400
Received: from gprs214-249.eurotel.cz ([160.218.214.249]:50820 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269302AbUIYKQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 06:16:56 -0400
Date: Sat, 25 Sep 2004 12:16:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pascal Schmidt <pascal.schmidt@email.de>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040925101640.GB4039@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it> <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it> <E1CB10O-0000HL-FJ@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CB10O-0000HL-FJ@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The problem isn't really that you're out of memory. Rather, the memory
> > is so fragmented that swsusp is unable to get an order 8 allocation in
> > which to store its metadata. There isn't really anything you can do to
> > avoid this issue apart from eating memory (which swsusp is doing
> > anyway).
> 
> That's one megabyte, right? Can't we preallocate that on boot, while
> there's still chance to get that much contiguous memory? If the
> user has swsusp compiled into his kernel, he probably wants it to
> function, so it's not really "wasted".

You do not know how much you should preallocate, because it depends on
ammount of memory used. You could preallocate maximum possible
ammount...

OTOH this is first report of this failure. If it fails once in a blue
moon, it is probably better to let it fail than waste memory.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
