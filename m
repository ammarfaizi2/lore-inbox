Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVE3IVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVE3IVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVE3IVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:21:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39889 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261556AbVE3IVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:21:20 -0400
Date: Mon, 30 May 2005 10:17:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swsusp: "sleeping function called from invalid context"
Message-ID: <20050530081708.GB13119@elf.ucw.cz>
References: <20050528091846.GA2628@cray.fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528091846.GA2628@cray.fish.zetnet.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Despite the dire warnings in Documentation/power/swsusp.txt, I decided to try
> out swsusp on my 1.2GHz Duron desktop machine. I used 2.6.12-rc5, and the
> following command line given in the documentation:
> 
> echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> 
> On resume, the kernel log (attached) had a number of scheduling while atomic
> warnings, and the bash process used to initiate the suspend segfaulted.
> 
> I did this test from a clean boot, from the console without loading
> X11.

Try it without CONFIG_PREEMPT, for now... I'll eventually have to fix
this one.
									Pavel
