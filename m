Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWGDPZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWGDPZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGDPZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:25:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22542 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751037AbWGDPZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:25:57 -0400
Date: Tue, 4 Jul 2006 15:25:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Petr Tesarik <ptesarik@suse.cz>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-ID: <20060704152544.GA4351@ucw.cz>
References: <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <1152004929.3374.13.camel@elijah.suse.cz> <1152012907.23628.20.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152012907.23628.20.camel@lappy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Add a salvagable file system to ext4, i.e. when a file is deleted, you 
> > > > just rename it and move it to a directory called DELETED.SAV and recycle 
> > > > the files as people allocate new ones.  Easy to do (internal "mv" of 
> > > 
> > > 
> > > Easily doable in userspace, why bother with kernel programming
> > 
> > Yes and no. A simple mv is better done in userspace, but what I'd
> > _really_ appreciate would be a true kernel salvage (similar to the way
> > NetWare does things). That means marking the file as deleted in the

I have code doing ld_preload tricks to force safe deletion... somewhere.

> Wouldn't such a scheme interfere with the block allocator algorithms,
> and hence increase the risk of fragmentation? Schemes like this realy
> put my hairs on end,
> 
>   1) if you don't want to lose your data, make backups; 
>   2) if I mean to delete a file, I want it gone proper. Silently keeping
>      it about is not unix like;

Well, mc supports undelete on ext2 for a *long* time. And it works
okay...

And yes, doing echo > important_file instead of echo >> important file
is way too easy with unix shells.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
