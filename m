Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVACTId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVACTId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVACTF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:05:29 -0500
Received: from mail.tmr.com ([216.238.38.203]:10508 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261552AbVACTEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:04:48 -0500
Date: Mon, 3 Jan 2005 13:41:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050103180430.GM2980@stusta.de>
Message-ID: <Pine.LNX.3.96.1050103133625.28268A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Adrian Bunk wrote:

> On Mon, Jan 03, 2005 at 12:18:36PM -0500, Bill Davidsen wrote:
> >...
> > The "few minor exceptions:"
> > 
> > SCSI command filtering - while I totally support the idea (and always
> > have), I miss running cdrecord as a normal user. Multisession doesn't work
> > as a normal user (at least if you follow the man page) because only root
> > can use -msinfo. There's also some raw mode which got a permission denied,
> > don't remember as I was trying something not doing production stuff.
> > 
> > APM vs. ACPI - shutdown doesn't reliably power down about half of the
> > machines I use, and all five laptops have working suspend and non-working
> > resume. APM seems to be pretty unsupported beyond "use ACPI for that."
> >...
> 
> More serious were other problems like e.g. the problems XFS has (had?) 
> with the 4kB stacks option on i386 that was introduced in 2.6
> after 2.6.0 . 

Can't speak for XFS, but the 4k stack issue was an option, and could be
investigated with care. I only found one case where 4k would repeatably
cause a problem, and the fix was in the -bk before I had a decent test
case. I am going to try XFS in a month or so, I have a chance to bench JFS
vs. XFS for an application with 40-50k files in a directory. Hope it works
by then if it doesn't now, I'm told BSD works well.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

