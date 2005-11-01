Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVKAVrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVKAVrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKAVrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:47:10 -0500
Received: from tim.rpsys.net ([194.106.48.114]:56226 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751219AbVKAVrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:47:09 -0500
Subject: Re: Make spitz compile again
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Russell King <rmk@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051101200516.GA7172@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz>
	 <1130773530.8353.39.camel@localhost.localdomain>
	 <20051101200516.GA7172@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 21:46:52 +0000
Message-Id: <1130881612.8489.33.camel@localhost.localdomain>
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

I've worked out a patch to revert the change that broke things for c7x0:

http://www.rpsys.net/openzaurus/patches/revert_bootmem-r0.patch

I'd be interested to know if this helps your spitz kernel as its gets
c7x0 working again. Obviously the next step is to work out why this
breaks things but reverting it gets my Zaurus dev tree working again
which stops users c7x0 complaining :)

Richard

