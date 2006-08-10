Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWHJRET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWHJRET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWHJRET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:04:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932494AbWHJRES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:04:18 -0400
Date: Thu, 10 Aug 2006 10:00:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
Message-Id: <20060810100012.abc1b5a1.akpm@osdl.org>
In-Reply-To: <44DB5FC0.5070405@us.ibm.com>
References: <1155172597.3161.72.camel@localhost.localdomain>
	<44DACB21.9080002@garzik.org>
	<44DB5FC0.5070405@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 09:33:04 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> Jeff Garzik wrote:
> > Mingming Cao wrote:
> > 
> >> This series of patch forkes a new filesystem, ext4, from the current
> >> ext3 filesystem, as the code base to work on, for the big features such
> >> as extents and larger fs(48 bit blk number) support, per our discussion
> >> on lkml a few weeks ago. 
> > 
> 
> > [...]
> > 
> >> Any comments? Could we add ext4/jbd2 to mm tree for a wider testing?
> > 
> > 
> > ext4 developers should create a git tree with the consensus-accepted 
> > patches.
> > 
> > That way Linus can pull as soon as the merge window opens, Andrew is 
> > guaranteed to have the latest in his -mm tree, and users and other 
> > kernel hackers can easily follow the development without having to 
> > gather scattered patches from lkml.
> >
> 
> We do maintain a quilt(akpm) style patches on http://ext2.sf.net, the 
> latest patches are always at 
> http://ext2.sourceforge.net/48bitext3/patches/latest/
> 
> We thought about doing git initially, still open for that doing do, if 
> it's more preferable by Linus or Andrew. Just thought  it's a lot 
> easiler for non git user to pull the patches from a project website.
> 

We should aim to get the big copy-ext3-to-ext4 patch into Linus's tree as
early as possible.

I'm just not sure when to do that.  Immediately after 2.6.19-rc1 is
released would be good because it is when every tree (including -mm) is in
its most-synced-up state.

otoh, we should work out what our processes will be for keeping ext3 and
ext4 in sync wrt bugfixes, cleanups, speedups, etc.  If those processes are
good, we can do the copy-n-paste any time.  And they need to be good...
