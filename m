Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVACRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVACRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVACRnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:43:39 -0500
Received: from mail.tmr.com ([216.238.38.203]:57099 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261758AbVACRmr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:42:47 -0500
Date: Mon, 3 Jan 2005 12:18:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050103134727.GA2980@stusta.de>
Message-ID: <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Adrian Bunk wrote:

> On Mon, Jan 03, 2005 at 02:24:12PM +0100, Diego Calleja wrote:
> > El Mon, 3 Jan 2005 06:33:04 +0100 Willy Tarreau <willy@w.ods.org> escribió:
> > 
> > > I clearly don't agree with you, for a simple reason : those out-of-tree
> > > features will always be, because each distro likes to add a few features,
> > > like SquashFS, PaX, etc... And indeed, that's one of the reasons I *stay*
> > > on 2.4. It's so simple to simply upgrade the kernel, patch and recompile
> > > without spending days complaining "grrr... why did they change this ?".
> > 
> > 
> > 2.6 will stop having small issues in each release until 2.7 is forked just
> > like 2.4 broke things until 2.5 was forked. The difference IMO
> > is that linux development now avoids things like the unstability which the
> > 2.4.10 changes caused and things like the fs corruption bugs we saw in 2.4
> >...
> 
> The 2.6.9 -> 2.6.10 patch is 28 MB, and while the changes that went into 
> 2.4 were limited since the most invasive patches were postponed for 2.5, 
> now _all_ patches go into 2.6 .
> 
> Yes, -mm gives a bit more testing coverage, but it doesn't seem to be 
> enough for this vast amount of changes.

I have to say that with a few minor exceptions the introduction of new
features hasn't created long term (more than a few days) of problems. And
we have had that in previous stable versions as well. New features
themselves may not be totally stable, but in most cases they don't break
existing features, or are fixed in bk1 or bk2. What worries me is removing
features deliberately, and I won't beat that dead horse again, I've said
my piece.

The "few minor exceptions:"

SCSI command filtering - while I totally support the idea (and always
have), I miss running cdrecord as a normal user. Multisession doesn't work
as a normal user (at least if you follow the man page) because only root
can use -msinfo. There's also some raw mode which got a permission denied,
don't remember as I was trying something not doing production stuff.

APM vs. ACPI - shutdown doesn't reliably power down about half of the
machines I use, and all five laptops have working suspend and non-working
resume. APM seems to be pretty unsupported beyond "use ACPI for that."

None of these would prevent using 2.6 if there were some feature not in
2.4 which gave a reason to switch.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

