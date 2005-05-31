Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVEaTO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEaTO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVEaTOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:14:25 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:6273 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261263AbVEaTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:13:32 -0400
Date: Tue, 31 May 2005 12:23:49 -0700
From: Greg KH <gregkh@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci-sysfs: backport fix for 2.6.11.12
Message-ID: <20050531192349.GA21050@suse.de>
References: <20050531163619.GA6711@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531163619.GA6711@mellanox.co.il>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 07:36:19PM +0300, Michael S. Tsirkin wrote:
> Greg, before 2.6.12, pci_write_config in pci-sysfs.c was broken, causing
> incorrect data being written to the configuration register,
> which in the case of my userspace driver results in system failure.
> 
> This has been fixed in 2.6.12-rc5:
> 
> http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fpatch-2.6.12-rc5.bz2;z=2656
> 
> Would you please consider merging the fix for 2.6.11.12 as well?

Would you care to split out only the proper part for that fix?  There
are a few different patches in that link above.

> Alternatively (since there were multiple other changes in pci-sysfs.c), here's
> a small patch to fix just this issue.

I don't think this fixes the problem properly.  Can you verify it?
Also, this is only a 64bit issue, right?  What platform are you seeing
this on?

And, any patch that you want to propose for the -stable releases, needs
to be sent to the stable@kernel.org email alias.

thanks,

greg k-h
