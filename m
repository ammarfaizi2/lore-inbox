Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVAUKko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVAUKko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVAUKkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:40:43 -0500
Received: from gprs215-198.eurotel.cz ([160.218.215.198]:18868 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262336AbVAUKj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:39:56 -0500
Date: Fri, 21 Jan 2005 11:39:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Jenkins <aj504@student.cs.york.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 suspend-to-disk bug (during resume)
Message-ID: <20050121103921.GH18373@elf.ucw.cz>
References: <1106210882.7975.9.camel@linux.site> <1106210985l.8224l.0l@linux> <20050120145804.GJ476@openzaurus.ucw.cz> <1106298500.10018.2.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106298500.10018.2.camel@linux.site>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 10 (level, low) -> IRQ 10
> > > bad: scheduling while atomic!
> > >  [<c030164e>] schedule+0x4be/0x570
> > >  [<c011ce69>] call_console_drivers+0x79/0x110
> > >  [<c0124817>] __mod_timer+0x177/0x190
> > >  [<c0301b8a>] schedule_timeout+0x5a/0xb0
> > >  [<c0293ed9>] 
> 
> > Try without preempt for an ugly workaround. 
> Check.

??? Sorry, I do not understand.

> > Also try to reproduce it
> > on 2.6.11-rc1.
> Looks the same.  I can send demsg output if required.

Ok, looks like I should enable PREEMPT here.

But resume succeeds at the end, no? We'll probably need to fix those
warnings, but driver model has bigger priority just now.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
