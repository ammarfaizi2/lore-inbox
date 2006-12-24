Return-Path: <linux-kernel-owner+w=401wt.eu-S1753980AbWLXAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbWLXAIH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 19:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbWLXAIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 19:08:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51093 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753982AbWLXAIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 19:08:05 -0500
Date: Sun, 24 Dec 2006 01:07:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: ptrace() memory corruption?
Message-ID: <20061224000753.GA1811@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <20061224000150.GA1812@elf.ucw.cz> <20061224000605.GA1768@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224000605.GA1768@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-12-24 01:06:05, Pavel Machek wrote:
> On Sun 2006-12-24 01:01:50, Pavel Machek wrote:
> > Hi!
> > 
> > > > I got this nasty oops while playing with debugger. Not sure if that is
> > > > related; it also might be something with bluetooth; I already know it
> > > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > > error path?
> > > 
> > > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > > cycles... so it is probably unrelated to the previous crash.
> > > 
> > > I was getting pretty regular crashes with bluetooth & gdb, but I was
> > > not using bluetooth at the time of ext3-related crash.
> > 
> > And for completeness, here's bluetooth + gdb oops. Ok, I'm not _sure_
> > it is bluetooth related. I'll try it without bluetooth in a while.
> 
> Ok, so this one is not bluetooth related. My little "phone"
> application provokes nasty oops, even when talking to
> /dev/null. Strange, that code does _nothing_
> strange. (www.sf.net/projects/tui).
> 
> Is there something wrong with gdb?

Yep. If I do gdb /bin/bash, run; I'll get similar oops. Am I alone
seeing this?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
