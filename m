Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935564AbWKZUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935564AbWKZUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935565AbWKZUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:52:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19077 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S935564AbWKZUwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:52:55 -0500
Date: Sun, 26 Nov 2006 21:52:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       seife@suse.de
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061126205235.GA13647@elf.ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <20061122152328.GI5200@stusta.de> <20061122154230.74889e3d@localhost.localdomain> <20061124234015.GB4782@ucw.cz> <20061125160821.1fd4f9c8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125160821.1fd4f9c8@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hmm... how common are these machines? We are using unpatched kernel
> > for suse10.2... OTOH we only support machines from the whitelist, all
> 
> I've always said IDE and software suspend are unsafe. The more work I do
> the more clearly this is/was the case.

Well, there's unsafe as in  "crashes", and that's unsafe as in "eats
disks".

> The really nasty "resume eats your disk" cases I know about are
> thankfully for older systems - VIA KT133 and similar era chipsets.

Aha, good. Hopefully noone has notebook with those.

> There is a recent nasty - Jmicron goes totally to **** on resume because
> of resume quirks not being run but it goes so spectacularly wrong it
> doesn't seem to get far enough to corrupt.

Good :-). Crashing is nasty, but we probably won't add that machine to
whitelist.

> Andrew has about 2/3rds of the bits I've done now, will push the rest
> when I've done a little more testing/checking. At that point libata ought
> to be resume safe. Someone who cares about drivers/ide legacy support can
> then copy the work over.

Thanks. I do not think we care about old mainboards enough to do
2.6.16-stable backport.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
