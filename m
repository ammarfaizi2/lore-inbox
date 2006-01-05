Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWAEBiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWAEBiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAEBiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:38:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750873AbWAEBiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:38:09 -0500
Date: Wed, 4 Jan 2006 17:38:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.15
In-Reply-To: <20060105004826.GA17328@kroah.com>
Message-ID: <Pine.LNX.4.64.0601041724560.3279@g5.osdl.org>
References: <20060105004826.GA17328@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jan 2006, Greg KH wrote:
>
> Here are a lot of driver core patches for 2.6.15.  They have all been in
> the past few -mm releases with no problems.

Strange, because it doesn't merge with your other own changes. It might be 
an ordering thing (ie they might have merged fine in another order). Or 
maybe it's just because the -mm scripts will force-apply patches (or drop 
them).

Anyway, there were clashes in drivers/usb/core/usb.c with the patch "USB: 
fix usb_find_interface for ppc64" that came through your USB changes, and 
that gets a merge error with the uevent/hotplug thing.

I can do the trivial manual fixup, but when I do, I have two copies of 
"usb_match_id()": one in drivers/usb/core/driver.c and one in 
drivers/usb/core/usb.c.

I've pushed out my tree, so that you can see for yourself (it seems to 
have mirrored out too).

		Linus
