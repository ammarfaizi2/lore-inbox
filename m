Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVEANTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVEANTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVEANTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:19:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261499AbVEANTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:19:32 -0400
Date: Sun, 1 May 2005 15:19:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
Message-ID: <20050501131931.GA3592@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org> <200504300827.44359.tomlins@cam.org> <Pine.LNX.4.61.0504301634590.3559@montezuma.fsmlabs.com> <200504301853.40395.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504301853.40395.tomlins@cam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 06:53:40PM -0400, Ed Tomlinson wrote:
> On Saturday 30 April 2005 18:36, Zwane Mwaikambo wrote:
> > On Sat, 30 Apr 2005, Ed Tomlinson wrote:
> > 
> > > If we stick with git it might make sense not to include a linux-patch.  cogito
> > > is quite fast to export using a commit id.  Suspect some bandwidth could be 
> > > saved if you just stated the commit id that you based the mm patch on.
> > > 
> > > In case anyone is wondering how build this from a cogito/git db...  Find the
> > > cogito announcement on lkml install and update cogito.  Then folliw the instructions
> > > in the README and download the kernel's db.  Next search lkml to find the commit id 
> > > of rc3 (a2755a80f40e5794ddc20e00f781af9d6320fafb) and verify you have it correct 
> > > with:
> > > 
> > > cg-mkpatch a2755a80f40e5794ddc20e00f781af9d6320fafb
> > > 
> > > then export a tree with
> > > 
> > > cg-export ../12-3-1 a2755a80f40e5794ddc20e00f781af9d6320fafb
> > > 
> > > and cd over to the new dir and patch with mm and have fun.
> > 
> > That'd be a horribly convoluted procedure and make automation difficult,
> > -mm shouldn't be that difficult to use. Also linus.patch used to be the 
> > current -bk snapshot.
> 
> Huh?  Assuming one already has a current git tree.  Then all Andrew need do
> is publish the commit id from Linus then the complicated procedure becomes
>...
> With bk there was an acceptable excuse not to use it.  With git, aside from bandwidth
> concerns (maybe mercurial can solve this), I do not see any good reason not to use it.


The reasons why I for one do not plan to use git are:

- disk space
- bandwidth (rsync traffic has to go through our masquerader, and the 
             amount of traffic through the masquerader I'm allowed to 
             generate is limited)
- I do not need Linus' tree for anything.
  I'm working against -mm because it's further in development.


Having said this, Andrew might perhaps be able to _additionally_ provide 
-mm patches without linus.patch for the convenience of git users.


> Ed Tomlinson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

