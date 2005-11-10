Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKJJcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKJJcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVKJJcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:32:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750719AbVKJJcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:32:15 -0500
Date: Thu, 10 Nov 2005 01:30:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: James.Bottomley@SteelEye.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-Id: <20051110013055.77120a56.akpm@osdl.org>
In-Reply-To: <20051110092241.GY3699@suse.de>
References: <20051109133558.513facef.akpm@osdl.org>
	<1131573041.8541.4.camel@mulgrave>
	<Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
	<1131575124.8541.9.camel@mulgrave>
	<20051109150141.0bcbf9e3.akpm@osdl.org>
	<20051110084025.GW3699@suse.de>
	<20051110005653.3cb2c90f.akpm@osdl.org>
	<20051110092241.GY3699@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Thu, Nov 10 2005, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > >  It's more of a "I don't feel like spending 1-2 hours making and testing
> > >  a -mm version"
> > 
> > There shouldn't be a need for special -m version of patches.  Very usually
> > the diff-against-linus can be made to work quite easily.  Sufficiently
> > easily that I resync with all the git trees a couple of times a day.
> 
> Often the patch itself may not take too much work, but you still need to
> set up a -mm test directory, compile, boot, and test the stuff.

Most of the other git-tree maintainers don't bother with any of that. 
acpi, agp, alsa, arm, ...  xfs.  The trees which have special -mm branches
are just drm, ieee1394, jfs, mips and netdev.

Where it all comes unstuck at present is if a maintainer has multiple
branches, and some of those branches contains diffs which are in other
branches.  If that happens, the diffs I generate throw huge rejects. 
But even then, if one branch is a strict superset of another, I can just
pull the superset one.
