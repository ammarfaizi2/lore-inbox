Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUBCTZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUBCTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:44 -0500
Received: from gprs159-73.eurotel.cz ([160.218.159.73]:27776 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266068AbUBCTOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:14:11 -0500
Date: Tue, 3 Feb 2004 20:13:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040203191336.GA372@elf.ucw.cz>
References: <20040123185914.GA870@elf.ucw.cz> <Pine.LNX.4.44.0401231402580.22566-100000@chimarrao.boston.redhat.com> <20040123210449.GA250@elf.ucw.cz> <bv46lv$6pu$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bv46lv$6pu$1@gatekeeper.tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | > > I'm afraid it needs to be more aggressive.
> | > 
> | > OK, is the patch below any better ?
> | 
> | Yes, this one actually works. When I launched two 150MB tasks, one of
> | them with ulimit -m 1, the limited task yielded its memory to
> | unlimited one. It worked as expected.
> 
> I'm not sure what "as expected" means with this small a limit, hopefully
> not "pages its butt off." I am printing a hardcopy of the 2nd patch and
> a bit of the surrounding code, and also compiling a new kernel with the
> patch in place, so I can play a bit in the morning.

Well, it should mean "all the memory from this process should be
reclaimed if it is needed".

> I also wonder if a sanity check is desirable on the minimum size. At
> some point I would think the system would get a lot of overhead trying
> to actually use a single 1k page :-(

I believe it is okay as is. It just gives it very low "memory-priority".

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
