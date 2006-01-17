Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWAQL7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWAQL7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWAQL7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:59:48 -0500
Received: from ns.suse.de ([195.135.220.2]:24529 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750763AbWAQL7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:59:47 -0500
Date: Tue, 17 Jan 2006 12:59:45 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: unmount oops in log_do_checkpoint
Message-ID: <20060117115945.GC24083@wotan.suse.de>
References: <20060116160420.GA21064@wotan.suse.de> <20060116212250.GD12159@atrey.karlin.mff.cuni.cz> <20060117113727.GB24083@wotan.suse.de> <20060117034601.6556322a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117034601.6556322a.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 03:46:01AM -0800, Andrew Morton wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> >
> > On Mon, Jan 16, 2006 at 10:22:50PM +0100, Jan Kara wrote:
> > > > 2.6.15-git12 (and 11, not sure when it started) oops when unmounting
> > > > an ext3 filesystem. Looks like 'transaction' in log_do_checkpoint is
> > > > garbage.
> > > > 
> > 
> > [oops]
> > 
> > >   It would be useful to find out which patch cause it (by git bisect)
> > > but one obvious suspect is my merged ext3 patch to checkpoint.c. I'll
> > > investigate tomorrow.
> > > 
> > 
> > Yep, reverting jbd split checkpoint lists in -git12 fixes it. It is
> > 100% reproducible so far, and every time rebooting with a patched
> > kernel fails to result in the oops.
> > 
> 
> But that patch was in -mm for months.  How come you didn't hit the oops
> earlier?  One would almost expect some odd patch interaction, but changes
> in ext3 have been small for a long time.

Haven't run -mm on that machine for quite a while, unfortunately.

What's strange is that nobody else has hit it... 


