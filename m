Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbSKAMEc>; Fri, 1 Nov 2002 07:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSKAMEc>; Fri, 1 Nov 2002 07:04:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14778 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263249AbSKAMEb>;
	Fri, 1 Nov 2002 07:04:31 -0500
Date: Fri, 1 Nov 2002 13:10:45 +0100
From: Jens Axboe <axboe@suse.de>
To: chrisl@vmware.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sasha Malchik <sasha@vmware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE CDROM packet command buffer size restriction.
Message-ID: <20021101121045.GK8428@suse.de>
References: <20021101044646.GB8603@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101044646.GB8603@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31 2002, chrisl@vmware.com wrote:
> Hi Alan,
> 
> Jens seems too busy to check out this patch. I post it here again
> hopefully to get boarder audiences:

Yes sorry, it's fallen through the cracks.

> VMware try to use the generic packet interface (CDROM_SEND_PACKET)
> for cdrom simulation. There are some packet command used by windows
> can return different data size, depend on the type of CD in the CDROM.
> Current linux kernel will fail the ioctl call if packet command return
> data less than expected.
> 
> ide-scsi driver do not have this problem.
> 
> We make a patch allow kernel return successful and return the actual
> transfer data size. Is it the prefer behavior in this case? If not,
> what is the best way to solve this problem?

The patch does look good, thanks.

> P.S. I am very surprised to find out that, vmware suffers from bugs
> in cdrom driver for years. Developers give up after some attempt to
> submit patches to kernel, it is not easy to make it right at the first
> time. The broken sense data bug should have been fix long time ago if
> they try hard enough.

I can only say resend and resend. It's no secret that I regurlarly loose
patches and don't respond to emails, because there are just so many of
them.

-- 
Jens Axboe

