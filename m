Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUJKQGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUJKQGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269078AbUJKQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:02:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:44990 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269073AbUJKQBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:01:06 -0400
Date: Mon, 11 Oct 2004 18:01:05 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011160105.GE26350@wotan.suse.de>
References: <20041011032502.299dc88d.akpm@osdl.org> <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com> <20041011154934.GD26350@wotan.suse.de> <Pine.LNX.4.61.0410111857260.2869@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410111857260.2869@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 06:58:01PM +0300, Zwane Mwaikambo wrote:
> On Mon, 11 Oct 2004, Andi Kleen wrote:
> 
> > On Mon, Oct 11, 2004 at 06:47:45PM +0300, Zwane Mwaikambo wrote:
> > > How about the following?
> > > 
> > > remove-lock_section-from-x86_64-spin_lock-asm.patch
> > >   remove LOCK_SECTION from x86_64 spin_lock asm
> > > 
> > > allow-x86_64-to-reenable-interrupts-on-contention.patch
> > >   Allow x86_64 to reenable interrupts on contention
> > > 
> > > The former is a fix.
> > 
> > What does it fix? 
> 
> Well we don't have lock section anymore since the spinlock text is all in 
> the out of line functions. So this was really something i missed in my 
> sweep.

I think the linker handles it anyways, so it's probably not critical
(without that it would slash'n'burn immediately)

-Andi
