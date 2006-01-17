Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWAQLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWAQLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWAQLqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:46:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbWAQLqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:46:24 -0500
Date: Tue, 17 Jan 2006 03:46:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: jack@suse.cz, npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: unmount oops in log_do_checkpoint
Message-Id: <20060117034601.6556322a.akpm@osdl.org>
In-Reply-To: <20060117113727.GB24083@wotan.suse.de>
References: <20060116160420.GA21064@wotan.suse.de>
	<20060116212250.GD12159@atrey.karlin.mff.cuni.cz>
	<20060117113727.GB24083@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> On Mon, Jan 16, 2006 at 10:22:50PM +0100, Jan Kara wrote:
> > > 2.6.15-git12 (and 11, not sure when it started) oops when unmounting
> > > an ext3 filesystem. Looks like 'transaction' in log_do_checkpoint is
> > > garbage.
> > > 
> 
> [oops]
> 
> >   It would be useful to find out which patch cause it (by git bisect)
> > but one obvious suspect is my merged ext3 patch to checkpoint.c. I'll
> > investigate tomorrow.
> > 
> 
> Yep, reverting jbd split checkpoint lists in -git12 fixes it. It is
> 100% reproducible so far, and every time rebooting with a patched
> kernel fails to result in the oops.
> 

But that patch was in -mm for months.  How come you didn't hit the oops
earlier?  One would almost expect some odd patch interaction, but changes
in ext3 have been small for a long time.
