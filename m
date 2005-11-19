Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVKTVWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVKTVWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVKTVWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:22:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59877 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750795AbVKTVWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:22:46 -0500
Date: Sat, 19 Nov 2005 23:44:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hui Cheng <hcheng@cse.unl.edu>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Pavel Machek <pavel@suse.cz>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: How to quickly detect the mode change of a hard disk?
Message-ID: <20051119234450.GB1952@spitz.ucw.cz>
References: <20051116185628.M35560@linuxwireless.org> <Pine.GSO.4.44.0511181333540.20511-100000@cse.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0511181333540.20511-100000@cse.unl.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I am currently doing a kernel module involves detecting/changing
> > > > disk mode among STANDBY and ACTIVE/IDLE. I used ide_cmd_wait() to issue
> > > > commands like WIN_IDLEIMMEDIATELY and WIN_STANDBYNOW1. The problem is, a
> > > > drive in standby mode will automatically awake whenever a disk operation
> > > > is requested and I need to know the mode change as soon as possible. (So I
> > >
> > > AFAIK there's no nice way to get that info, but it is useful, so
> > > patch would be welcome.
> >
> > I would check the hdparm man page again. Still, it sounds interesting.
> >
> > Additionally, it could be cool if someone could finish up or make the option
> > for the HD freeze to use it with the HDAPS driver. ;-)
> >
> > .Alejandro
> >
> 
> Thanks for reply :) What I did to handle this problem is a little stupid
> : Suppose the disk is now in a standby mode. In case that there is a
> request sent to the disk drive, a kernel thread is awake to detect/update
> the current disk power mode. The disk power mode is stored in the
> ide_drive_t structure and be protected by lock. It seems to work fine in
> my simple tests. But again, there should be better solutions.

Can we get the patch?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

