Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUKCVbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUKCVbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKCV26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:28:58 -0500
Received: from fep18.inet.fi ([194.251.242.243]:47322 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261891AbUKCVYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:24:14 -0500
Date: Wed, 3 Nov 2004 23:24:09 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB CD/disk not working after 2.6.7
Message-ID: <20041103212409.GC13063@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041103183425.GB13063@m.safari.iki.fi> <41893E4E.3090602@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41893E4E.3090602@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:23:42PM -0500, Bill Davidsen wrote:
> Sami Farin wrote:
> >On Wed, Nov 03, 2004 at 12:20:58PM -0500, Bill Davidsen wrote:
> >
> >>Since 2.6.7 no kernel has seen my USB CD burner or disk. I took the disk 
> >>off to simplify the picture, it still doesn't work.
> >
> >...
> >
> >>Buffer I/O error on device uba, logical block 0
> >>unable to read partition table
> >
> >
> >remove this line from .config and rebuild kernel...
> >CONFIG_BLK_DEV_UB=y
> >
> >...and it will just work.
> >
> Thank you for the prompt answer! I've started rebuilding the kernel.

Good luck.

> Do you know if  the incompatibility between flash key support and 
> CD/disk a bug, design decision, or unavoidable characteristic of the 
> devices involved? I have some kind of a flash key coming for evaluation, 
> so I built with that on.

AFAIK, usb-storage works fine with all those USB memory sticks / pen drives
without CONFIG_BLK_DEV_UB and I have absolutely no idea whatsoever what
"flash keys" UB is supposed to support.
I would have assumed that UB enables you to use some flash
key (such as?) which isn't supported by any other USB driver but seems UB
stomps on usb-storage and breaks in many cases and you can't use the usual
USB CF-readers etc with CONFIG_BLK_DEV_UB=y because UB is buggy.
well, defconfig has CONFIG_BLK_DEV_UB disabled.

maybe Pete Zaitcev can enlighten us.

http://en.wikipedia.org/wiki/Keydrive
"flash key" missing from that list? *shrug*

-- 
