Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWILWib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWILWib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWILWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:38:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:23973 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932251AbWILWia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:38:30 -0400
Date: Tue, 12 Sep 2006 15:33:09 -0700
From: Greg KH <gregkh@suse.de>
To: Jody Belka <lists-lkml@pimb.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060912223309.GA9271@suse.de>
References: <20060912150433.GB2808@pimb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912150433.GB2808@pimb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 04:04:33PM +0100, Jody Belka wrote:
> Upgrading to this causes my copy of hal (0.5.3-0ubuntu14) to fail to start.
> Bisecting tracked it down to the following commit. Reverting just this patch
> against 2.6.18-rc6 gets things working again.
> 
> 
> 9bde7497e0b54178c317fac47a18be7f948dd471 is first bad commit
> commit 9bde7497e0b54178c317fac47a18be7f948dd471
> Author: Greg Kroah-Hartman <gregkh@suse.de>
> Date:   Wed Jun 14 12:14:34 2006 -0700
> 
>     [PATCH] USB: make endpoints real struct devices
> 
>     This will allow for us to give endpoints a major/minor to create a
>     "usbfs2-like" way to access endpoints directly from userspace in an
>     easier manner than the current usbfs provides us.
> 
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Yes, this exposed a bug in HAL where it was overflowing an internal
buffer.  Please upgrade to the latest version, it has been fixed for a
few months now.

thanks,

greg k-h
