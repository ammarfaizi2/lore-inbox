Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWBPTcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWBPTcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWBPTcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:32:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60601 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932561AbWBPTcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:32:01 -0500
Date: Fri, 17 Feb 2006 06:31:57 +1100
From: Nathan Scott <nathans@sgi.com>
To: bjd <bjdouma@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060217063157.B9349752@wobbly.melbourne.sgi.com>
References: <20060216183629.GA5672@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060216183629.GA5672@skyscraper.unix9.prv>; from bjdouma@xs4all.nl on Thu, Feb 16, 2006 at 07:36:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 07:36:29PM +0100, bjd wrote:
> Trying to mount a corrupted xfs partition hanging off a Promise
> PDC20267 FastTrak100/Ukltra100 controller.
> 
> The partition contains a test Linux system that, due to an in-
> complete install, had to be halted by brute force (i.e. power off).

Any idea how/at what point it became corrupted?

> After a reboot and xfs_repair the filesystem proved to be mildly
> corrupted, but recoverable.
> 

This filesystem has not been repaired, if it had you would not
be going into log recovery when you mount it (xfs_repair clears
out the log).

> XFS mounting filesystem hda3
> Starting XFS recovery on filesystem: hda3 (logdev: internal)
> EIP:    0060:[xlog_recover_do_inode_trans+473/2688]    Tainted: P      VLI

This indicates you are running recovery - run xfs_repair first
if you know the filesystem is corrupt.

cheers.

-- 
Nathan
