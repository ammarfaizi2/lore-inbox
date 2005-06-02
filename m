Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVFBVwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVFBVwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVFBVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:50:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5251 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261231AbVFBVrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:47:39 -0400
Date: Thu, 2 Jun 2005 23:47:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Freezer Patches.
Message-ID: <20050602214714.GB1980@elf.ucw.cz>
References: <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz> <1117665934.19020.94.camel@gaston> <20050601230235.GF11163@elf.ucw.cz> <1117676753.10888.105.camel@localhost> <20050602071431.GA1841@elf.ucw.cz> <1117697187.10888.138.camel@localhost> <20050602073119.GC1841@elf.ucw.cz> <1117697772.31082.54.camel@gaston> <1117700339.10888.141.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117700339.10888.141.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Whatever you guys decide to do (I actually do sys_sync() before freezing
> > on pmac and yes, it takes sometimes way too long), to be uber-safe, we
> > could/should _also_ do sync after freezing userland processes and before
> > freezing kernel threads (that is, splitting here). In fact, that would
> > help also avoid deadlocks where a frozen kernel thread is holding a
> > semaphore preventing a process from freezing.
> > 
> > That way, if we sys_sync() once processes are sleeping and before kernel
> > threads are, we pretty-much make sure no new dirty buffer will appear.
> > 
> > Anyway, that's mostly food for thoughts at this point
> 
> I fully agree, and that's what I'm already doing. Nothing I can do about
> Pavel not seeing logic, so guess I just have to hope everyone else does
> :)

I think I see your logic, and it is wrong. Anyway, just do not touch
fork/exit hot paths.
								Pavel

