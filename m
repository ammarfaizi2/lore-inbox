Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVCDLFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVCDLFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVCDLFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:05:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39100 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262718AbVCDLCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:02:07 -0500
Date: Fri, 4 Mar 2005 12:01:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, hugang@soulinfo.com
Subject: Re: swsusp: use non-contiguous memory on resume
Message-ID: <20050304110154.GK1345@elf.ucw.cz>
References: <20050304095934.GA1731@elf.ucw.cz> <20050304021347.1b3e0122.akpm@osdl.org> <20050304102121.GG1345@elf.ucw.cz> <20050304025119.4b3f8aa6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304025119.4b3f8aa6.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Problem is that pagedir is allocated as order-8 allocation on resume
> >  in -mmX (and linus). Unfortunately, order-8 allocation sometimes
> >  fails, and for some people (Rafael, seife :-) it fails way too often.
> > 
> >  Solution is to change format of pagedir from table to linklist,
> >  avoiding high-order alocation. Unfortunately that means changes to
> >  assembly, too, as assembly walks the pagedir.
> 
> Ah.
> 
> >  (Or maybe Rafael is willing to create -mm version and submit it
> >  himself?)
> 
> No, against -linus, please.  But the chunk in kernel/power/swsusp.c looks
> like it came from a diff between -mm and -linus.  Or something.

Yes, I did diff between -mm and -pavel, sorry.

But I can't easily generate diff against -linus because that one is
dependend on fixing order-8 allocations during suspend. So I guess
I'll just wait until that one propagates into -linus?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
