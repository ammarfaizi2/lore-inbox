Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVIQW1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVIQW1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVIQW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 18:27:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:9093 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751140AbVIQW1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 18:27:18 -0400
Date: Sat, 17 Sep 2005 15:26:40 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ST 5481 USB driver
Message-ID: <20050917222640.GA27785@kroah.com>
References: <20050917215242.GA27813@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917215242.GA27813@pingi3.kke.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 11:52:42PM +0200, Karsten Keil wrote:
>  	// Cancel all USB transfers on this B channel
> +	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
>  	usb_unlink_urb(b_out->urb[0]);
> +	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;

URB_ASYNC_UNLINK is now gone in 2.6.14-rc1, so this change will break
the build :(

thanks,

greg k-h
