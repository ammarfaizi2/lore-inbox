Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWBGXhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWBGXhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWBGXhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:37:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31393 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932479AbWBGXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:37:14 -0500
Date: Wed, 8 Feb 2006 00:36:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bojan Smojver <bojan@rexursive.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207233653.GA10520@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080814.02894.nigel@suspend2.net> <20060207230510.GF2753@elf.ucw.cz> <200602080917.24305.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080917.24305.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please do not patch kernel for that.
> > 
> > Proper solution is probably creating s2disk program/script, and teach
> > kpowersave/klaptop/etc. to just use it. Then s2disk can detect best
> > method to use ... and then just do it. You already have suitable
> > script, but I'm not sure what its name is.
> 
> It occured to me as soon as I sent the last email (don't you hate that!)
> that I'd forgotten the original impetus: backwards compatibility. If all
> of the methods of suspending can be started with
> 
> "echo disk > /sys/power/state"
> 
> , your backwards compatability issue that you expressed concern about 
> earlier in this discussion is addressed. So, I'm not sure that dropping the
> idea is the right thing to do.

Yes, it probably is. echo > /sys/*/state needs to work for a while,
but we should really move everyone into running single command. Your
hibernate script probably good start. (I'd call it hibernate, not
hibernate.sh, so it does not *have* to be implemented in shell).
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
