Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269627AbUJLLxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269627AbUJLLxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269637AbUJLLxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:53:00 -0400
Received: from gprs213-46.eurotel.cz ([160.218.213.46]:10113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269627AbUJLLw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:52:58 -0400
Date: Tue, 12 Oct 2004 13:51:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041012115108.GC2354@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410102126220.3897@ppc970.osdl.org> <1097470524.3249.34.camel@gaston> <200410110915.33331.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410110915.33331.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well... it doesn't work on paul's laptop, but anyway, ok, let's go for
> > the struct thing and forget about this for 2.6.9.
> 
> PM hasn't worked for me on 2.6 with most hardware, about since
> the "new PMcore" kicked in, so it's hard for me to judge progress
> except at the level of unit tests.  Where I see two steps forward,
> one step back ... on a good day.
> 
> The root cause of many of these problem is that there's
> a confusion between system-wide sleep states and the
> device-specific power states from which they're built.
> They _should_ be using two distinct data types.  Not one
> integer/enum type ... especially not one int/enum type
> that's got multiple conflicting "legacy" interpretations!

Actually I do not see what is so wrong with one enum type; with sparse
we have typechecking, and if someone assigns value from one enum into
another enum, he's clearly doing something wrong.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
