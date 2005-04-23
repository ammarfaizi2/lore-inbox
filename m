Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVDWXip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVDWXip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVDWXip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:38:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:47768 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262178AbVDWXil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:38:41 -0400
Date: Sat, 23 Apr 2005 16:38:09 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Linus Torvalds <torvalds@osdl.org>,
       Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423233809.GA21754@kroah.com>
References: <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx> <20050423220213.GA20519@kroah.com> <20050423222946.GF1884@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423222946.GF1884@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 12:29:46AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > A word of warning: in many ways it's easier to work with patches. In
> > > > particular, if you want to have me merge from your tree, I require a
> > > > certain amount of cleanliness in the trees I'm pulling from. All of the
> > > > people who used to use BK to sync are already used to that, but for people
> > > > who didn't historically use BK this is going to be a learning experience.
> > > > 
> > > 
> > > Is there a summary available of the major issues here so that we who are
> > > new to this can get up to speed fairly quickly?
> > 
> > The main issue is if you want to use git for development and accepting
> > patches from others, you need to be used to not using that git tree to
> > send patches to Linus.  To send patches to him, do something like the
> > following:
> > 	- export the patches from your git tree
> > 	- pick and choose what you want to send off, cleaning up the
> > 	  changelog comments and merging patches that need to be.
> > 	- clone the latest copy of Linus's tree.
> > 	- apply the patches to that tree.
> > 	- make the tree public
> > 	- generate an email with the diffs and send that off to lkml and
> > 	  Linus.
> > 
> > Because of all of this, I've found that it is easier to use quilt for
> > day-to-day development and acceptance of patches.  Then use git to build
> > up trees for Linus to pull from.
> > 
> > But you might find your workflow is different :)
> 
> How does Andrew fit into this picture, btw? I thought all patches ought
> to go through him... Is Andrew willing to pull from git trees? Or is
> it "create one version for akpm, and when he ACKs it, create another
> for Linus"?

Yeah, getting Andrew into the picture is a bit different.  Previously,
with bk, I could just have him pull from my trees, and generate a patch
from that.  And actually, with git that would work just as well, so if
you make your git working trees public, he can pull from them and you're
fine.

But with quilt it's different.  That's why I make up a big patch which
is the sum of my individual patches and put them on a public site.
Right now you can see this at:
	kernel.org/pub/linux/kernel/people/gregkh-2.6/
The patches in that directory are the "rolled up" ones.  The script
there is what I use to build these patches, if you want to do something
like it.

In the patches/ subdir below that one, is a mirror of my quilt patches
directory, series file and all.  That way people can still see the
individual patches if they want to.

Does this help some?  It's all still under flux as to how this all
works, try something and go from there :)

thanks,

greg k-h
