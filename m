Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266642AbUAWS7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266606AbUAWS7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:59:35 -0500
Received: from gprs214-223.eurotel.cz ([160.218.214.223]:45440 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266642AbUAWS7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:59:32 -0500
Date: Fri, 23 Jan 2004 19:59:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040123185914.GA870@elf.ucw.cz>
References: <20040122010438.GD223@elf.ucw.cz> <Pine.LNX.4.44.0401212010520.15146-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401212010520.15146-100000@chimarrao.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ulimit -m 1
> > <some task>
> > 
> > should make that task run with extremely low priority, right?
> 
> Yeah, when the box is under memory pressure, pages from that
> task should never hit the active list.  Instead, they should
> always stay on the inactive list and the non-referenced pages
> from that app should get reclaimed.
> 
> OTOH, if the app keeps referencing all pages, maybe I need
> to tune up the aggressiveness a bit and also reclaim the
> referenced pages ... if the current patch doesn't work right
> I'll make a more aggressive one.

I'm afraid it needs to be more aggressive.

I made two programs, each walking over 150MB of memory, and ran them
at same time on 250MB machine. One of them with ulimit -m 1... Both
got about the same ammount of RAM and progressed at similar speed.

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
