Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293563AbSBZK1f>; Tue, 26 Feb 2002 05:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293562AbSBZK1Y>; Tue, 26 Feb 2002 05:27:24 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:28607 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293561AbSBZK1S>; Tue, 26 Feb 2002 05:27:18 -0500
Date: Tue, 26 Feb 2002 04:27:14 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
Message-ID: <20020226042714.C930@asooo.flowerfire.com>
In-Reply-To: <E16feI5-0008WC-00@the-village.bc.nu> <Pine.LNX.4.10.10202260131250.14807-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10202260131250.14807-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Tue, Feb 26, 2002 at 01:37:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 01:37:55AM -0800, Andre Hedrick wrote:
[...]
| The real solution for distros is to wrapper the dma_capable flags in the
| module cores in 2.4 under the disk_only.  Also not setting
| CONFIG_IDEDMA_AUTO will help but you are not permitted to invoke
| 
| echo using_dma:1 > /proc/ide/hda/settings

I noticed that "hdparm -d1 /dev/hda" timed out three times and reverted
to PIO in my case, with DMA enabled but autoDMA disabled.  So does DMA
support have to be on at boot and is only allowed to be disabled, not
enabled?

If so, ide=dma is the proper solution for trusted boards, but it would
be nice if the /proc or hdparm interfaces worked reliably for enabling
DMA.

So what does this say about the autoDMA issue that I'm seeing?  For me,
the best of both worlds is to have DMA enabled, but off by default and
capable of being enabled from userspace (and kernel command line, less
usefully).

Thanks,
-- 
Ken.
brownfld@irridia.com


| One of the issues to be address is a test for transfer modes, but have to
| many other issues to address w/ clients to deal with distro issues.
| 
| Cheers,
| 
| Andre Hedrick
| Linux Disk Certification Project                Linux ATA Development
