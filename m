Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFSSxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFSSxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFSSxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:53:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20360 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261282AbVFSSxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:53:14 -0400
Date: Sun, 19 Jun 2005 19:55:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Maitin-Shepard <jbms@cmu.edu>,
       Patrick McFarland <pmcfarland@downeast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050619175503.GA3193@elf.ucw.cz>
References: <f192987705061303383f77c10c@mail.gmail.com> <f192987705061310202e2d9309@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain> <200506152149.06367.pmcfarland@downeast.net> <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx> <20050616143727.GC10969@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616143727.GC10969@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ext2/3's encoding has always been utf-8.  Period.
> > 
> > In what way does Ext2/3 know or care about file name encoding?  Doesn't
> > it just store an arbitrary 8-byte string?  Couldn't someone claim that
> > from the start it was designed to use iso8859-1 just as easily as you
> > can claim it was designed to use utf-8?
> 
> Because we've had this discussion^H^H^H^H^H^H^H^H^H^H^H flame war
> years ago, and despite people from Russia whining that that it took 3
> bytes to encode each Cyrillic character in UTF-8, it's where we came out.  
> 
> The bottom-line though is that if someone files a bug report with ext3
> because one user on the system was is creating filenames in Japanese,
> and another user on the same time-sharing system is creating filenames
> in Germany, and they fail to interoperate, and they were doing so in
> their local language, we would laugh at them --- just as people
> writing mail programs would laugh at people who complained that they
> were running into problems Just Sending 8-bits instead of using MIME,
> and could you please fix this business-critical bug?  
> 
> Or as more and more desktop programs start interpreting the filenames
> as UTF-8, and people with local variations get screwed, that is their
> problem, and Not Ours.

Actually the day we have rm utf-8-ed, we have a problem. Someone will
create two files that have same utf name, encoded differently, and
will be in trouble. Remember old > \* "hack"? utf-8 makes variation
possible...

If we are serious about utf-8 support in ext3, we should return
-EINVAL if someone passes non-canonical utf-8 string.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
