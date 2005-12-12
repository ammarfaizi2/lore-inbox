Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVLNLn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVLNLn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLNLn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:43:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932432AbVLNLn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:43:57 -0500
Date: Mon, 12 Dec 2005 12:49:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Message-ID: <20051212114952.GB6533@elf.ucw.cz>
References: <20051203135608.GJ31395@stusta.de> <200512102330.31572.rob@landley.net> <20051211083737.GF5187@elf.ucw.cz> <200512110312.47142.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512110312.47142.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why use udev from initramfs?
> 
> I don't, but I do use a script that mknods the real root's node based on 
> running "find" against /sys to locacate the appropriate device name and then 
> finding the major/minor numbers there.
> 
> This has nothing whatsoever to do with ipw2200.  It just means I'm not using 
> the in-kernel root-finder code.
> 
> > Just teach ipw2200 to load firmware late.
> 
> That's now how I'd fix this.  If you want to fix it this way, be my guest.
> 
> > Don't load firmware when ipw2200 is initialized, load it only 
> > when someone attempts to talk to your ipw2200. At that time, you
> > should have userland already.
> 
> Or I could move initramfs extraction earlier in the boot sequence and never 
> have to modify any _other_ drivers that want firmware in order to be able to 
> make them work too, rather than playing whack-a-mole teaching drivers I don't 
> care about how to hold off on wanting firmware.

Except that whack-a-mole is a right thing to do here, and that
initramfs movement is unlikely to make it into mainline.
							Pavel
-- 
Thanks, Sharp!
