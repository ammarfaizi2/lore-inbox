Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVDWWCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVDWWCx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVDWWCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:02:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:53985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbVDWWCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:02:51 -0400
Date: Sat, 23 Apr 2005 15:02:13 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423220213.GA20519@kroah.com>
References: <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426A7775.60207@drzeus.cx>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 06:27:33PM +0200, Pierre Ossman wrote:
> Linus Torvalds wrote:
> > 
> > A word of warning: in many ways it's easier to work with patches. In
> > particular, if you want to have me merge from your tree, I require a
> > certain amount of cleanliness in the trees I'm pulling from. All of the
> > people who used to use BK to sync are already used to that, but for people
> > who didn't historically use BK this is going to be a learning experience.
> > 
> 
> Is there a summary available of the major issues here so that we who are
> new to this can get up to speed fairly quickly?

The main issue is if you want to use git for development and accepting
patches from others, you need to be used to not using that git tree to
send patches to Linus.  To send patches to him, do something like the
following:
	- export the patches from your git tree
	- pick and choose what you want to send off, cleaning up the
	  changelog comments and merging patches that need to be.
	- clone the latest copy of Linus's tree.
	- apply the patches to that tree.
	- make the tree public
	- generate an email with the diffs and send that off to lkml and
	  Linus.

Because of all of this, I've found that it is easier to use quilt for
day-to-day development and acceptance of patches.  Then use git to build
up trees for Linus to pull from.

But you might find your workflow is different :)

Hope this helps,

greg k-h
