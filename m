Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTIAU1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTIAU1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:27:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37647
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262076AbTIAU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:27:20 -0400
Date: Mon, 1 Sep 2003 13:27:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030901202729.GB31760@matchmail.com>
Mail-Followup-To: Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20030830235819.GD898@matchmail.com> <20030831164448.O15623@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831164448.O15623@schatzie.adilger.int>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 04:44:48PM -0600, Andreas Dilger wrote:
> On Aug 30, 2003  16:58 -0700, Mike Fedyk wrote:
> > But how do I re-enable htree on the directories (besides an fsck -D) in a
> > live system?
> 
> You need to re-enable the dir_index feature, and then for directories which
> are larger than a block in size you need something like:
> 
> 	mkdir new_dir
> 	mv old_dir/* new_dir
> 	rmdir old_dir
> 	mv new_dir old_dir
> 
> The new directory will have htree enabled because it started out at 1 block
> in size.

Ok I ended up doing this after a little thought.  Thanks.

But I am seeing segfaults in mutt under 2.6 ext3 with 1k blocks, that I
don't see in 2.4, and didn't see under reiserfs.  I can try with 4k blocks,
if you'd like, is there anything I can do to capture more information that
could be happening to cause this?

And now mutt is segfaulting on non-htree directories too.
