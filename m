Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbULEXqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbULEXqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULEXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:46:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261423AbULEXqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:46:08 -0500
Date: Mon, 6 Dec 2004 00:46:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dynamic syscalls revisited
Message-ID: <20041205234605.GF2953@stusta.de>
References: <1101741118.25841.40.camel@localhost.localdomain> <20041129151741.GA5514@infradead.org> <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr> <1101748258.25841.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101748258.25841.53.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:10:58PM -0500, Steven Rostedt wrote:
> On Mon, 2004-11-29 at 17:41 +0100, Jan Engelhardt wrote:
> > I do not see how dsyscalls could be better than static ones, so they are
> > one-on-one. Maybe someone could elaborate why they are "a really bad idea"?
> 
> The one argument against them, that I agree with, is Linus' hooks to
> avoid the GPL.  A binary only module could easily add their own hooks
> into the kernel.
> 
> I've made this patch with the option to turn this off. I should have put
> the option in Kernel debugging with the default off (the default is
> currently on so that if you apply the patch, you have it automatically).
> This way binary only modules can't take advantage of the dynamic
> syscalls without recompiling the kernel.  If the user needed to compile
> the kernel, then a patch can easily be added, so this is just as good of
> a defense. 

Why don't you EXPORT_SYMBOL_GPL dsyscall_{,un}register?

This should at least fix the binary only module concerns.

> -- Steve

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

