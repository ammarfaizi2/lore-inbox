Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVBGGro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVBGGro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVBGGre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:47:34 -0500
Received: from ozlabs.org ([203.10.76.45]:17555 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261365AbVBGGrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:47:31 -0500
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data
	corruption
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200502062115.07626.david-b@pacbell.net>
References: <1107519382.1703.7.camel@localhost.localdomain>
	 <200502041241.28029.david-b@pacbell.net>
	 <1107744922.8689.6.camel@localhost.localdomain>
	 <200502062115.07626.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 17:46:30 +1100
Message-Id: <1107758790.8689.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 21:15 -0800, David Brownell wrote:
> And I didn't see an "unusual_devs.h" entry for it, but it does
> look to need the CONFIG_USB_STORAGE_HP8200e support, which I
> see is labeled "experimental".  I don't know how solid the
> support for that is.   But I see Greg's checked in a big patch
> against the file with that driver, which should make the next
> MM patchset against 2.6.11-rc3 ... mostly to support some
> new hardware, but with that many changes I suspect there'll
> be some bugfixes too.

OK, I'll check once that comes through, thanks.

> This would be www.macpower.com.tw/produts/hdd2/daisycutter/dc_usb2
> maybe?  The www.qbik.ch/usb/devices database has a report from one
> user saying they had problems with a different MacPower adapter until
> they fixed its jumpers.  Also worth a check.

Actually, it's
http://www.macpower.com.tw/products/hdd2/clearlight/cl_400plus

I didn't put the drive in myself, but I'll unscrew it and check the
jumpers.

A simple DIRECT_IO 4096-byte read-write on the block device does reveal
corruption after an hour or so, so I should be able to track this down.
Might move my home dir back off it for a while though 8)

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

