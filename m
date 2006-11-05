Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWKEW2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWKEW2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbWKEW2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:28:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:53901 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161702AbWKEW2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:28:46 -0500
From: Neil Brown <neilb@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Date: Mon, 6 Nov 2006 09:28:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17742.26007.249504.79631@cse.unsw.edu.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: [RFC][PATCH -mm][Experimental] suspend: Do not freeze md_threads
In-Reply-To: message from Pavel Machek on Sunday November 5
References: <200611022355.52856.rjw@sisk.pl>
	<20061105115804.GG4965@elf.ucw.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 5, pavel@ucw.cz wrote:
> Hi!
> 
> > If there's a swap file on a software RAID, it should be possible to use this
> > file for saving the swsusp's suspend image.  Also, this file should be
> > available to the memory management subsystem when memory is being freed before
> > the suspend image is created.
> > 
> > For the above reasons it seems that md_threads should not be frozen during
> > the suspend and the appended patch makes this happen, but then there is the
> > question if they don't cause any data to be written to disks after the
> > suspend image has been created, provided that all filesystems are frozen
> > at that time.
> 
> Looks okay to me. It would be nice to have someone (Ingo? Neil?) try
> to suspend to swap on md......

Yes... suspending to swap-on-md would probably be fairly easy.
Resuming from that same swap might be a bit more of a challenge.
If only I had more time...

but the patch looks good to me.  I'll see that it gets applied.
Thanks,

NeilBrown

