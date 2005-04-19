Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVDSVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVDSVkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDSVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:40:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:10679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261264AbVDSVkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:40:35 -0400
Date: Tue, 19 Apr 2005 14:40:09 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-ID: <20050419214009.GA25681@kroah.com>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 01:20:47PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 19 Apr 2005, Greg KH wrote:
> > 
> > Ok, if you want some practice with "real" merges, feel free to merge from
> > the following two trees whenever you are ready:
> > 	kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
> > for 11 aoe bugfix patches, and:
> > 	kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> > for 13 driver core, sysfs, and debugfs fixes.
> 
> Done, pushed out. Can you verify that the end result looks sane to you? I 
> just cheched that the diffstat looks similar (mine claims just 108 lines 
> changed in aoecmd.c - possibly due to different diff formats).

Looks good to me (the diffstat difference is probably because the
patches were consecutive, and the sum of them are smaller (modifying
same parts of the files, etc.))

The git-changes-script shows that you picked up everything from my trees
successfully (assuming we trust that so far) and a raw diff looks good
too.

Two "odd" things in the changelog:

commit caaaaebc2380426b64aaa60a169834a7aefc956c
tree 484292d57c19acbf04cf5c783e7d26181b95e96e
parent 334a4e1b19f7f471594f7abd3bfead3720c1bd61
author Hugh Dickins <hugh@veritas.com> Wed, 20 Apr 2005 03:29:23 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org.(none)> Wed, 20 Apr 2005 03:29:23 -0700

It looks like your domain name isn't set up properly for your box (which
is why it worked for you, but not me before, causing that patch).

Also the date is in the future with the -0700, yet the time is in UTC.
Oh wait, that's a 'git log' thing, the raw changeset is correct, I guess
I'll wait for Pasky to fix that :)

> And yes, my new merge thing seems to have kept the index-cache much better 
> up-to-date, allowing an optimized checkout-cache -f -a to work and only 
> get the new files.

Very nice.

thanks,

greg k-h
