Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVB0WXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVB0WXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVB0WXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:23:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261498AbVB0WX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:23:26 -0500
Date: Mon, 28 Feb 2005 09:22:16 +1100
From: Nathan Scott <nathans@sgi.com>
To: Torben Viets <Viets@web.de>, Stephen Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS dm_crypt BUG?
Message-ID: <20050228092215.F2644066@wobbly.melbourne.sgi.com>
References: <422214D6.2000206@web.de> <422220C7.8090001@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <422220C7.8090001@xfs.org>; from lord@xfs.org on Sun, Feb 27, 2005 at 01:34:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 01:34:31PM -0600, Stephen Lord wrote:
> Torben Viets wrote:
> > 
> > I have a RAID 5(md0) with 3 disks on md0 (chunk-size 128) there is a 
> > ...
> > I can't show you the kernel panic message, because I didn't found it in 
> > the syslog, it is only on the screen,
> ...
> Just on a hunch, check if you have 4K stacks turned on, if you do, go
> back to 8K stacks and see if that cures it.

Also (if still an option) try mkfs'ing the filesystem with
a sector size matching your blocksize (eg. -ssize=4k), which
will make XFS's IO patterns a little more uniform.  This has
resolved RAID5 driver confusion in the past, so worth a shot.

cheers.

-- 
Nathan
