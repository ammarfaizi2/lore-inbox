Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUIZKNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUIZKNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUIZKNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:13:21 -0400
Received: from gprs214-184.eurotel.cz ([160.218.214.184]:10626 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268812AbUIZKNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:13:19 -0400
Date: Sun, 26 Sep 2004 12:09:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926100955.GI10435@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <20040925234045.GA17856@elf.ucw.cz> <200409261208.02209.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409261208.02209.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've just tried to suspend my box and I must admit I've given up after 30 
> > > minutes (sic!) of waiting when there were only 12% of pages written to 
> disk.  
> > > Apparently, swsusp slows down to an unacceptable level after saying "PM: 
> > > Writing image to disk".
> > > 
> > > The box is an Athlon 64-based notebook.  The .config is available at:
> > > http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3.config
> > > and the output of dmesg is available at:
> > > http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3-dmesg.log
> > 
> > We have seen something similar after hdparm was used on specific
> > machines. Are you using hdparm?
> 
> Not explicitly, but it's used by SuSE initscripts to set IDE DMA, AFAICS.  
> However, the problem did not occur on 2.6.9-rc2-mm1 with the same 
> initscripts.

Okay, so try what happens without the initscripts and try to locate
change that breaks it...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
