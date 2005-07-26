Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVGZUI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVGZUI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGZUI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:08:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261985AbVGZUIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:08:20 -0400
Date: Tue, 26 Jul 2005 22:08:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-ID: <20050726200812.GA12202@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The reboot code paths seems to be suffering from 15 years of people
> only looking at the code when it breaks.  The result is there
> are several code paths in which different callers expect different
> semantics from the same functions, and a fair amount of imperfect
> inline replication of code.
> 
> For a year or more every time I fix one bug in the bug fix reveals yet
> another bug.  In an attempt to end the cycle of bug fixes revealing
> yet more bugs I have generated a series of patches to clean up
> the semantics along the reboot path.
> 
> With the callers all agreeing on what to expect from the functions
> they call it should at least be possible to kill bugs without
> more showing up because of the bug fix.
> 
> My primary approach is to factor sys_reboot into several smaller
> functions and provide those functions for the general kernel
> consumers instead of the architecture dependent restart and
> halt hooks.
> 
> I don't expect this to noticeably fix any bugs along the
> main code paths but magic sysrq and several of the more obscure
> code paths should work much more reliably.

It looks good to me. Good ammount of cruft really accumulated there...

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
