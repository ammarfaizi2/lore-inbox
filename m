Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUJZJPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUJZJPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUJZJPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:15:12 -0400
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:43650 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262103AbUJZJPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:15:02 -0400
Date: Tue, 26 Oct 2004 11:14:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Zhu, Yi" <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [swsusp] print error message when swapping is disabled (fwd)
Message-ID: <20041026091449.GA28897@elf.ucw.cz>
References: <Pine.LNX.4.44.0410260949340.18363-100000@mazda.sh.intel.com> <20041026023858.GA7467@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026023858.GA7467@taniwha.stupidest.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	if ((error = swsusp_swap_check())) {
> > +		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
> > +				"swapon -a!\n");
> 
> maybe it's just me, but i would really prefer to have the occasional
> long(er) line that splitting strings like that

It is not just you :-). Also it should probably not have KERN_ERR
level (it is not really error, you just asked for something that can
not be done) and word FATAL scares me.

But it is probably easier to put there some message first then fix it
up.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
