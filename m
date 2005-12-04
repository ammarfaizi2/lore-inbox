Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVLDX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVLDX0R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVLDX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:26:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:54734 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751143AbVLDXZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:25:52 -0500
Date: Sun, 4 Dec 2005 15:05:09 -0800
From: Greg KH <greg@kroah.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051204230509.GC8914@kroah.com>
References: <43923479.3020305@tls.msk.ru> <20051204003130.GB1879@kroah.com> <386F0C1C.1040509@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386F0C1C.1040509@tls.msk.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2000 at 11:28:12AM +0300, Michael Tokarev wrote:
> Greg KH wrote:
> >On Sun, Dec 04, 2005 at 03:12:41AM +0300, Michael Tokarev wrote:
> >
> >>When I try to "standby" (echo standby > /sys/power/state)
> >>a 2.6.14 system running on a VIA C3-based system with VIA
> >>chipset (suspend to disk never worked on this system --
> >>as stated on swsusp website it's due to the lack of some
> >>CPU instruction on this CPU [but winXP suspends to disk
> >>on this system just fine]), it immediately comes back, with
> >>the above error message:
> >
> >Can you try 2.6.15-rc4 or newer to see if that fixes this issue for you?
> 
> Yes, 2.6.15-rc4 restores previous functionality - the error in
> $subject is now gone, and it seems the system goes to standby
> as it should, without errors and 'standby process interruptions'.
> Thanks.
> 
> With the only problem which was here all the time - it comes "back
> to C" after less a secound all the disks/monitor/etc are placed
> into sleep mode..  Ie,
> 
>  ..preparing for standby...
>  ..hdd stops spinning..
>  ..monitor is turned off..
>  ..less-than-a-secound-pause..
>  Back to C!
>  ..the system goes back, restoring interrupts etc...
> 
> I tried various 'wakeup' settings in bios, incl. turning everything
> off in that menu - no difference.
> 
> The same behaviour is shown by all 2.6 kernels I tried so far
> (since 2.6.6 or so).

Does normal "suspend" work for you on this machine (echoing "disk" to
that sysfs file?)

I'd suggest creating a bugzilla.kernel.org entry for this new problem.

thanks,

greg k-h
