Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWBTAJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWBTAJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWBTAJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:09:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5008 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932469AbWBTAJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:09:20 -0500
Date: Mon, 20 Feb 2006 01:09:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060220000907.GE15608@elf.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net> <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 15:59:25, Patrick Mochel wrote:
> 
> On Sat, 18 Feb 2006, Pavel Machek wrote:
> 
> > Hi!
> >
> > > Fix the per-device state file to respect the actual state that
> > > is reported by the device, or written to the file.
> >
> > Can we let "state" file die? You actually suggested that at one point.
> >
> > I do not think passing states in u32 is good idea. New interface that passes
> > state as string would probably be better.
> 
> Yup, in the future that will be better. For now, let's work with what we
> got and fix 2.6.16 to be compatible with previous versions..

It already is. It accepts "0" and "2" and "3". That's all values that
used to work. Other values used to trigger BUG() in pci.c (and we do
not want to re-introduce _that_ behaviour, right?).

If you add u32 into pm_message_t, it will be impossible to remove in
future.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
