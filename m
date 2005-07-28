Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVG1WMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVG1WMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1WMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:12:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5014 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261536AbVG1WMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:12:31 -0400
Date: Fri, 29 Jul 2005 00:12:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
Message-ID: <20050728221228.GB1872@elf.ucw.cz>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net> <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz> <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz> <Pine.LNX.4.62.0507281251040.12675@graphe.net> <Pine.LNX.4.62.0507281254380.12781@graphe.net> <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz> <Pine.LNX.4.62.0507281456240.14677@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507281456240.14677@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Introduce a todo notifier in the task_struct so that a task can be told to do
> > > > certain things. Abuse the suspend hooks try_to_freeze, freezing and refrigerator
> > > > to establish checkpoints where the todo list is processed. This will break software
> > > > suspend (next patch fixes and cleans up software suspend).
> > > 
> > > Ugh, this conflicts with stuff in -mm tree rather badly... In part
> > > thanks to patch by you that was already applied.
> > > 
> > > I fixed up rejects manually (but probably lost fix or two in
> > > progress), and will test.
> 
> Dont fix it up. Remove the ealier patch.

Oops. Do you happen to have patch relative to -mm or something? I'd
prefer not to mess it up second time...

> > > You are doing rather intrusive changes. Is testing them too much to
> > > ask? I'm pretty sure you can get i386 machine to test swsusp on...
> > 
> > (And yes, I did apply the whole series. It would be nice if next
> > series was relative to -mm, it already contains some of your changes).
> 
> mm contains the TIF_FREEZE changes that need to be undone. And yes I 
> tested it on a i386 with suspend to disk and it worked fine.

Sorry.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
