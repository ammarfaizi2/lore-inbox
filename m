Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTFNWrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTFNWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:47:42 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:31363 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261561AbTFNWrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:47:39 -0400
Date: Sun, 15 Jun 2003 01:01:25 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mga dualhead console + gpm = instant reboot
Message-ID: <20030614230125.GA11783@vana.vc.cvut.cz>
References: <20030614014212.GC1010@dbz.icequake.net> <20030614214114.GE2776@vana.vc.cvut.cz> <20030614225001.GS867@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614225001.GS867@dbz.icequake.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 05:50:01PM -0500, Ryan Underwood wrote:
> On Sat, Jun 14, 2003 at 11:41:14PM +0200, Petr Vandrovec wrote:
> > On Fri, Jun 13, 2003 at 08:42:12PM -0500, Ryan Underwood wrote:
> > > Hello,
> > > 
> > > I run the mga dualhead console.  It works ok for the most part (some
> > > strange behavior on the second head happens that can be noticed in e.g.
> > > lynx when the cursor is blinking).  However, if I move the gpm mouse on
> > > the first head, switch to a console on the second head, move gpm mouse
> > > again, then switch back to a console on the first head, moving the mouse
> > > thereafter results in an instant reboot of the system.
> > > 
> > > Since there does not appear to be any kernel panic or oops, I am at a
> > > loss how to track the problem down.  Any ideas?
> > 
> > Kernel version? And if it is 2.4.x, did you boot with
> > 'video=scrollback:0' ? If not, then please do so...
> 
> Sorry, fresh 2.4.21, but it has happened on previous 2.4 kernels too.  I
> will look into the scrollback option.  What does that accomplish with
> respect to the mouse cursor?

It stops code from using software scrollback, which is common for both
heads, and which can corrupt memory if screen size on both /dev/fb* differs.

Maybe it wont help, but scrollback is known problem, so lets rule this
one out first.

I'll try to build some 2.4.x kernel on monday, but I assume that I would
notice such reboot during regular usage of dualhead system, as in the past
I was using 2.4.x...
								Petr
