Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVKAUTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVKAUTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVKAUTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:19:43 -0500
Received: from tim.rpsys.net ([194.106.48.114]:55728 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750961AbVKAUTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:19:42 -0500
Subject: Re: Make spitz compile again
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051101200516.GA7172@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz>
	 <1130773530.8353.39.camel@localhost.localdomain>
	 <20051101200516.GA7172@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 20:19:31 +0000
Message-Id: <1130876371.8489.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 21:05 +0100, Pavel Machek wrote:
> Hi!
> 
> > > This is what I needed to do after update to latest linus
> > > kernel. Perhaps it helps someone. 
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > > 
> > > , but it is against Richard's tree merged into my tree, so do not
> > > expect to apply it over mainline. Akita code movement is needed if I
> > > want to compile kernel without akita support...
> > 
> > This is an update of my tree against 2.6.14-git3:
> > 
> > http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0.patch.gz
> 
> I did compile fixing, but it still will not boot. With neither my
> config, not with yours. Just blank screen. Any ideas?
> 
> > http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0-defconfig-cxx00

I'm seeing the blank screen on the c7x0 models but my spitz kernels are
all working.

I've traced the c7x0 problem to this patch:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=90072059d2963dec237ae0cf49831ef77ddb5739

I've asked Russell and he doesn't know what's wrong. I'm trying to write
a patch which reverts this from 2.6.13-git3 but its complicated by some
of the later arm patches.

I was surprised the c7x0 problem happened and yet spitz was fine so
perhaps this is related to your problem.

Richard

