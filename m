Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVBHWg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVBHWg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVBHWdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:33:43 -0500
Received: from gprs215-154.eurotel.cz ([160.218.215.154]:46302 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261593AbVBHWc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:32:58 -0500
Date: Tue, 8 Feb 2005 23:32:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merging the Suspend2 freezer implementation.
Message-ID: <20050208223241.GC1347@elf.ucw.cz>
References: <1107822206.2756.18.camel@desktop.cunninghams> <20050208163644.GG1622@elf.ucw.cz> <1107899999.4330.39.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107899999.4330.39.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The main change involves the introduction of a new SYNCTHREAD flag. We
> > > use this to avoid deadlocking over processes that are running sys_sync
> > > and siblings. Processes that enter those routines get the flag added,
> > > and it's removed when they exit the sync routine. We then freeze in four
> > > stages: 
> > 
> > Is SYNCTHREAD neccessary for me, too, or is it needed for suspend2, only?
> 
> It's necessary for reliable freezing under I/O load. Signalling the
> non-sync threads first removes the race involved in some threads
> submitting I/O while others are trying to sync. Try doing a dd and a
> sync at the same time. The sync can take ages to return, worst case,
> sometimes not until the dd is completed. (Actually, try doing anything
> while a dd is running :>)

Okay, just attach this explanation when you are merging it otherwise
I'll surely ask again...

> > > Finally I'd like to merge the support for freezer flags on workqueues.
> 
> No comment here? :>

:-). I forgot why it was neccessary, but I was too shy to ask
;-). Just attach nice explanation when you attempt to merge it.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
