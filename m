Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUFDUJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUFDUJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUFDUJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:09:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:45034 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265970AbUFDUIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:08:46 -0400
Date: Fri, 4 Jun 2004 13:07:48 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040604200748.GA12855@kroah.com>
References: <20040604193911.GA3261@babylon.d2dc.net> <20040604195247.GA12688@kroah.com> <20040604200211.GB3261@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604200211.GB3261@babylon.d2dc.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 04:02:11PM -0400, Zephaniah E. Hull wrote:
> 
> lt-pilot-xfer D 00000000     0 11415   2709                     (NOTLB)
> d2ad3eb0 00000086 c022391a 00000000 3231203a 000a2e35 00000001 d2ad3ea7
>        d4edd000 d7fc8a00 c8449790 00000000 abb31900 000f447a c4bae4b8 c977d824
>        00000246 d2ad2000 d2ad3eec c0336735 c977d82c c4bae310 00000001 c4bae310
> Call Trace:
>  [<c0336735>] __down+0x85/0x120
>  [<c033692f>] __down_failed+0xb/0x14
>  [<c026af27>] .text.lock.hub+0x69/0x82
>  [<c0272b7f>] usbdev_ioctl+0x19f/0x710
>  [<c015a45d>] file_ioctl+0x5d/0x170
>  [<c015a686>] sys_ioctl+0x116/0x250
>  [<c0103f8f>] syscall_call+0x7/0xb
> 
> This is on 2.6.7-rc2-mm1.

Ah, can you not try the -mm1 kernel?  This problem should not be in the
mainline kernel.  There was a locking issue in the last bk-usb patch
that made it into the -mm1 kernel that was fixed yesterday.

thanks,

greg k-h
