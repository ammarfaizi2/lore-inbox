Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVEMSOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVEMSOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVEMSOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:14:01 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:29920 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262170AbVEMSNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:13:45 -0400
Date: Fri, 13 May 2005 14:13:43 -0400
To: Zan Lynx <zlynx@acm.org>
Cc: mhw@wittsend.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sync option destroys flash!
Message-ID: <20050513181343.GI23488@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain> <20050513171758.GB23621@csclub.uwaterloo.ca> <1116007099.29258.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116007099.29258.22.camel@localhost>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 11:58:19AM -0600, Zan Lynx wrote:
> Err, no, the sync flag is a wonderful idea.  I use sync on jump drives
> (although I won't now that I've read about this problem) because I can
> copy a file to it and as soon as the green light stops flashing I can
> yank it out without bothering to click or type anything to "eject" it.
> Requiring "eject" on removable media is a dumb idea.
> 
> Perhaps FAT updates could be cached and delayed until some # of ms after
> the last write.
> 
> Turning the sync flag off and adjusting the values
> in /proc/sys/vm/dirty_* would have the same effect, but would change it
> on all devices, not just removables.
> 
> Maybe we need a way to set dirty_* per block device?

Well you could just make a way to start writing data to the device
within 1s or so, and then assuming your device has a light indicating
activity (it better), then when the light has been off for a couple of
seconds, you can remove it.

I wish every removeable media drive had a soft eject button on it and a
locking mechanism like zip drive, jax drive, cdrom/dvd, mac floppy
drive, etc.  They are seriously needed to tell the os what the user is
trying to do to the poor media.  That way the os can see when the user
wants to take the media out, flush it, unlock and eject.  Doesn't help
if the eject button doesn't signal the OS of course, but at least on
some drives it does.  Being able to remove media from a system without
telling the OS first is just bad design.

Len Sorensen
