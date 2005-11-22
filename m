Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVKVPk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVKVPk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVKVPk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:40:26 -0500
Received: from cse-mail.unl.edu ([129.93.165.11]:58781 "EHLO cse-mail.unl.edu")
	by vger.kernel.org with ESMTP id S964963AbVKVPkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:40:25 -0500
Date: Tue, 22 Nov 2005 09:39:34 -0600 (CST)
From: Hui Cheng <hcheng@cse.unl.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Subject: Re: How to quickly detect the mode change of a hard disk?
In-Reply-To: <20051119234450.GB1952@spitz.ucw.cz>
Message-ID: <Pine.GSO.4.44.0511220934210.6696-100000@cse.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (cse-mail.unl.edu [129.93.165.11]); Tue, 22 Nov 2005 09:39:47 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Nov 2005, Pavel Machek wrote:
Hi,

> Hi!
>
> > > > > I am currently doing a kernel module involves detecting/changing
> > > > > disk mode among STANDBY and ACTIVE/IDLE. I used ide_cmd_wait() to issue
> > > > > commands like WIN_IDLEIMMEDIATELY and WIN_STANDBYNOW1. The problem is, a
> > > > > drive in standby mode will automatically awake whenever a disk operation
> > > > > is requested and I need to know the mode change as soon as possible. (So I
> > > >
> > > > AFAIK there's no nice way to get that info, but it is useful, so
> > > > patch would be welcome.
> > >
> > > I would check the hdparm man page again. Still, it sounds interesting.
> > >
> > > Additionally, it could be cool if someone could finish up or make the option
> > > for the HD freeze to use it with the HDAPS driver. ;-)
> > >
> > > .Alejandro
> > >
> >
> > Thanks for reply :) What I did to handle this problem is a little stupid
> > : Suppose the disk is now in a standby mode. In case that there is a
> > request sent to the disk drive, a kernel thread is awake to detect/update
> > the current disk power mode. The disk power mode is stored in the
> > ide_drive_t structure and be protected by lock. It seems to work fine in
> > my simple tests. But again, there should be better solutions.
>
> Can we get the patch?
> --

Sure. I will make the patch and test it again. But it may take a while
because I have an urgent task now...Thanks,

Hui

