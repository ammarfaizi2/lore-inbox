Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWDEQag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWDEQag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWDEQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:30:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9738 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751251AbWDEQag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:30:36 -0400
Date: Wed, 5 Apr 2006 18:30:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Per =?iso-8859-1?Q?=D8yvind?= Karlsen <peroyvind@sintrax.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols for drm module on sparc64
Message-ID: <20060405163034.GE8673@stusta.de>
References: <200604051530.00883.peroyvind@sintrax.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604051530.00883.peroyvind@sintrax.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 03:30:00PM +0200, Per Øyvind Karlsen wrote:
> When building 2.6.17-rc1 on sparc64 I run into this problem:
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map 
> -b /root/RPM/BUILD/kernel-linus-2.6/temp-root -r 2.6.17-rc1.16mdksmp; fi
> WARNING: /root/RPM/BUILD/kernel-linus-2.6/temp-root/lib/modules/2.6.17-rc1.16mdksmp/kernel/drivers/char/drm/drm.ko 
> needs unknown symbol dma_alloc_coherent
> WARNING: /root/RPM/BUILD/kernel-linus-2.6/temp-root/lib/modules/2.6.17-rc1.16mdksmp/kernel/drivers/char/drm/drm.ko 
> needs unknown symbol dma_free_coherent
> make: *** [_modinst_post] Error 1
> 
> I'm not subscribed to the list, just thought that I should report since it 
> recently broke, so CC me if any more info is needed.
> I'm also attaching my .config in case it might be of help:)
>...

Thanks for your report.

This is a known bug, and a fix is available at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm1/broken-out/drm_pci-needs-dma-mappingh.patch
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

