Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276271AbRI1UCL>; Fri, 28 Sep 2001 16:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276280AbRI1UCC>; Fri, 28 Sep 2001 16:02:02 -0400
Received: from [194.213.32.137] ([194.213.32.137]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276271AbRI1UB4>;
	Fri, 28 Sep 2001 16:01:56 -0400
Message-ID: <20010926223814.A169@bug.ucw.cz>
Date: Wed, 26 Sep 2001 22:38:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921162949.H8188@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010921162949.H8188@mueller.datastacks.com>; from Crutcher Dunnavant on Fri, Sep 21, 2001 at 04:29:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.  I'd really prefer to see callers use
> > register_sysrq_key() and unregister_sysrq_key() so that they
> > can get/use return values, and not the lower-level functions
> > "__sysrq*" functions that are EXPORTed in sysrq.c.
> > I don't see a good reason to EXPORT all of these functions.
> 
> So would I, however, the lower interface is there so that modules can
> restructure the table in more complex ways, allowing for sub-menus.

This is kernel, and sysrq was designed to be debug tool. It turned out
to be more successfull than expected...

Just keep in mind its a debug tool. If you need hierarchical submenus,
then you are probably not using it as debug tool, right?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
