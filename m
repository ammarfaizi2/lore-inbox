Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWDYVqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWDYVqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDYVqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:46:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51599 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751323AbWDYVqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:46:53 -0400
Date: Tue, 25 Apr 2006 23:46:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dean gaudet <dean@arctic.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] off-by-1 in kernel/power/main.c
Message-ID: <20060425214613.GF6379@elf.ucw.cz>
References: <Pine.LNX.4.64.0604212055390.24100@twinlark.arctic.org> <20060422213754.GA23981@elf.ucw.cz> <Pine.LNX.4.64.0604231958020.22072@twinlark.arctic.org> <20060424075725.GB26345@elf.ucw.cz> <Pine.LNX.4.64.0604251413430.10855@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604251413430.10855@twinlark.arctic.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Valid way to power off machine is by shutdown -o now, and there's a
> > > > syscall to do that. It should not be done by /sys/power/state.
> > > 
> > > hey... my shutdown doesn't have a -o option... where can i find that?
> > 
> > Not sure where I got it, because _my_ shutdown does not have -o,
> > either. Sorry. It has 
> > 
> >        -P     Halt action is to turn off the power.
> > 
> > however. Plus there's a syscall you can use...
> 
> "shutdown -hP now" just causes the machine to power off... i need it to go 
> into S5 -- because it'll only respond to wake-on-lan from S5.  it doesn't 
> respond to WOL after a "shutdown -hP now"...
> 
> ironically the off-by-1 bug let me get into S5... and i thought i had my 
> code working.
> 
> so what i'm really curious about now is the Right Way to go into S5...
> 
> somehow with fc4 "shutdown -h now" put it in S5, but with debian it 
> doesn't... and i haven't figured out yet where the fedora/debian 
> kernel/sysvinit patches differ on this behaviour.

There should not be any difference between S5 and poweroff...

Well, probably driver calls are different in regular case and your
"hacked up" one. Try to find the one that matters...
								Pavel
-- 
Thanks for all the (sleeping) penguins.
