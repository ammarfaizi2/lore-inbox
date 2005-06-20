Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVFTWtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVFTWtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVFTWsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:48:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5507 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262306AbVFTWTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:19:44 -0400
Date: Tue, 21 Jun 2005 00:19:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Maitin-Shepard <jbms@cmu.edu>,
       Patrick McFarland <pmcfarland@downeast.net>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050620221926.GJ2222@elf.ucw.cz>
References: <f192987705061303383f77c10c@mail.gmail.com> <f192987705061310202e2d9309@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain> <200506152149.06367.pmcfarland@downeast.net> <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx> <20050616143727.GC10969@thunk.org> <20050619175503.GA3193@elf.ucw.cz> <1119292723.3279.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119292723.3279.0.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually the day we have rm utf-8-ed, we have a problem. Someone will
> > create two files that have same utf name, encoded differently, and
> > will be in trouble. Remember old > \* "hack"? utf-8 makes variation
> > possible...
> 
> They are different to POSIX as they are different byte sequences

Does POSIX really say that all weird characters must be accepted in
path name?

> > If we are serious about utf-8 support in ext3, we should return
> > -EINVAL if someone passes non-canonical utf-8 string.
> 
> That would ironically not be standards compliant

I don't see how we can claim ext3 is utf-8 then. If application
vendors believed us and accepted that ext3 filenames are in utf-8,
they'd do wrong thing because kernel is perfectly willing to feed them
non-utf-8 things.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
