Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbTH3X6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbTH3X6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:58:19 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26124
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262287AbTH3X6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:58:18 -0400
Date: Sat, 30 Aug 2003 16:58:19 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030830235819.GD898@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030829172451.GA27023@matchmail.com> <20030829180957.GC27023@matchmail.com> <20030830131421.M15623@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830131421.M15623@schatzie.adilger.int>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 01:14:21PM -0600, Andreas Dilger wrote:
> On Aug 29, 2003  11:09 -0700, Mike Fedyk wrote:
> > On Fri, Aug 29, 2003 at 10:24:51AM -0700, Mike Fedyk wrote:
> >  o Find out that a directory is using htree?
> 
> "lsattr <dir>" will show it.  Note that it will only ever be set on
> directories that are larger than a single disk block.
> 
> # lsattr -d d1
> ----------I-- d1
> 

Ok, now I only have htree enabled on one of my maildir folders.

> >  o Disable htree on my /?  (tune2fs -O ^dir_index), but then how do I get
> >    my directories back to non-htree without running fsck from a rescue CD?
> 
> That's the great thing about htree - you don't need to do anything to turn
> it off.  The on-disk format is exactly the same as without htree, and the
> first time you modify the directory it will clear the per-directory htree
> flag.

I'll do more testing to see if it fails only on that folder now.

But how do I re-enable htree on the directories (besides an fsck -D) in a
live system?
