Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbTBSNso>; Wed, 19 Feb 2003 08:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbTBSNsn>; Wed, 19 Feb 2003 08:48:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53764 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268899AbTBSNsm>; Wed, 19 Feb 2003 08:48:42 -0500
Date: Wed, 19 Feb 2003 08:55:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Thomas Molina <tmolina@cox.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
In-Reply-To: <Pine.LNX.4.44.0302190105370.4923-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1030219084918.9798A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Thomas Molina wrote:

> On Tue, 18 Feb 2003, Bill Davidsen wrote:
> 
> > On Tue, 18 Feb 2003, Christoph Hellwig wrote:
> > 
> > > On Tue, Feb 18, 2003 at 02:02:10PM +0100, Marc-Christian Petersen wrote:
> > > > so you can disable all SCSI lowlevel drivers at once.
> > > 
> > > Why? just disable CONFIG_SCSI instead of adding an artifical option
> > 
> > Isn't that going to disable all of SCSI? I think the intention may be to
> > drop hardware drivers and just use ide-scsi, although I might be
> > misreading the original intent.
> > 
> > There are a fair number of tape/CD/DVD devices out there which you might
> > run SCSI. I many cases will run SCSI or not at all.
> 
> I thought the intent was to make it unnecessary to run ide-scsi at all.  

I don't think it matters, the idea is to avoid all the low-level SCSI
menus in one place, without disabling the ability to handle ATAPI devices.
Using the ide-scsi or not still uses SCSI drivers AFAIK.

> There was talk about it awhile back on the list.  I've been burning CDs 
> using ide cdrom support for several kernel revisions now.

Have you checked/used them? I kind of wrote that off after a while, I
don't need more coasters :-( At the time I deferred testing the score was
CD: read okay burn failed, ide-floppy (ZIP in my case): ng, and tape: not
even visible. That was back around 2.5.52 or so, since ide-scsi seems to
work I haven't been motivated to care.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

