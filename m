Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264008AbUKZUHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264008AbUKZUHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264007AbUKZUGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:06:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262608AbUKZTfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:14 -0500
Date: Thu, 25 Nov 2004 20:28:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Message-ID: <20041125192834.GB1302@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296414.5805.286.camel@desktop.cunninghams> <20041124132949.GB13145@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124132949.GB13145@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Here we add simple hooks so that the user can interact with suspend
> > while it is running. (Hmm. The serial console condition could be
> > simplified :>). The hooks allow you to do such things as:
> > 
> > - cancel suspending

I can understand that you want this one. I do not think uglyness is
worth it, through.

> > - change the amount of detail of debugging info shown

Use sysrq-X as you do during runtime.

> > - change what debugging info is shown
> > - pause the process
> > - single step

Usefull for developing swsusp but not for using it. Should live as a
separate patch.

> > - toggle rebooting instead of powering down

This is prety much nonsensical. You can do echo reboot > disk. If you
forget to do it, all you have to do is press power after it powers
down. That's about as much work as pressing 'R' while you are
suspending, right?

Please drop this one.

> And why would we want this?  If the users calls the suspend call
> he surely wants to suspend, right?
> 
> After all we don't have inkernel hooks to allow a user to read instead
> write after calling sys_write.

:-))))))))).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
