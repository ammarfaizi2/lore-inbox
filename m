Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265453AbTIDS2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTIDS0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:26:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49554 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265453AbTIDS0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:26:08 -0400
Date: Thu, 4 Sep 2003 20:26:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
Message-ID: <20030904182606.GB27650@atrey.karlin.mff.cuni.cz>
References: <20030904115824.GD24015@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm doing return -EAGAIN so I can call driver model myself, and so
> > that your code does not proceed with stopping tasks/etc after I've
> > done full suspend/resume cycle.
> > 
> > I see your point about S4. I want to use as little as power/main.c
> > infrastructure as possible for now, and this seems like the way to do
> > it.
> > 
> > Okay, it seems that I can move this to pm_suspend, and it will look better.
> 
> No, you have to understand that I don't want to call software_suspend() at 
> all. You've made the choice not to accept the swsusp changes, so we're 
> forking the code. We will have competing implementations of 
> suspend-to-disk in the kernel. 

I've said I want the patch reverted. I still want that, because you
changed way too quickly with too little testing. That does not mean
I'm not going to accept your patches in future. (In fact, my plan is
to  get -test3 version of swsusp back for -test5, then fix up driver
model/swsusp until we have -test3 functionality back, then start
taking your patches). 

Of course, that is going to be easier with your cooperation.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
