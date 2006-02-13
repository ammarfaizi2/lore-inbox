Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWBMSIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWBMSIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWBMSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:08:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932382AbWBMSIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:08:37 -0500
Date: Mon, 13 Feb 2006 10:04:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213174658.GC23048@redhat.com>
Message-ID: <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Dave Jones wrote:
>  
> I think this is the Radeon DRM bug I hit.  (rc1 had a big drm update iirc)

Ahh..

> Unless I patch with this..
> 
> --- linux-2.6.15.noarch/drivers/char/drm/drm_pciids.h~  2006-02-09 19:26:06.000000000 -0500
> +++ linux-2.6.15.noarch/drivers/char/drm/drm_pciids.h   2006-02-09 19:26:56.000000000 -0500
> @@ -85,7 +85,6 @@
>         {0x1002, 0x5969, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
>         {0x1002, 0x596A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
>         {0x1002, 0x596B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
> -       {0x1002, 0x5b60, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350}, \
>         {0x1002, 0x5c61, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|CHIP_IS_MOBILITY}, \

DaveA, I'll apply this for now. Comments?

		Linus
