Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUCBWgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUCBWds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:33:48 -0500
Received: from gprs40-190.eurotel.cz ([160.218.40.190]:7029 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262267AbUCBWdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:33:36 -0500
Date: Tue, 2 Mar 2004 23:33:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb: fix kgdbeth compilation and make it init late enough
Message-ID: <20040302223326.GF1225@elf.ucw.cz>
References: <20040302112500.GA485@elf.ucw.cz> <20040302153250.GE16434@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302153250.GE16434@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
> > probably not needd any more.
> 
> I don't know if we can do that.  There's some funky locking stuff done
> on SMP, which for some reason can't be done to NR_CPUS (or, no one has
> tried doing that).

There seems to be KGDB_MAX_NO_CPUS, but as 8250 patch does not check
it, I believe that eth has no business checking it either.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
