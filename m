Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUI0U0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUI0U0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0UWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:22:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56221 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267335AbUI0UTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:19:38 -0400
Date: Sun, 26 Sep 2004 15:20:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926132036.GG826@openzaurus.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <200409261208.02209.rjw@sisk.pl> <20040926100955.GI10435@elf.ucw.cz> <200409261337.53298.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409261337.53298.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Not explicitly, but it's used by SuSE initscripts to set IDE DMA, AFAICS.  
> > > However, the problem did not occur on 2.6.9-rc2-mm1 with the same 
> > > initscripts.
> > 
> > Okay, so try what happens without the initscripts
> 
> I turned the stuff off but of course it didn't change anything. :-)
> 
> > and try to locate change that breaks it...
> 
> Well, I'm a bit confused:

That's very simple bugfix. Some code outside swsusp is doing this.
Is it still slow with init=/bin/bash? If no, locate module that
causes slowdown. We've seen pcmcia support behaving strange.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

