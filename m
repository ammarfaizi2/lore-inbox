Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVLIR4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVLIR4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVLIR4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:56:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:25500 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964835AbVLIR4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:56:52 -0500
Date: Fri, 9 Dec 2005 09:55:55 -0800
From: Greg KH <greg@kroah.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14.3 - sysfs duplicated dentry bug
Message-ID: <20051209175555.GA9761@kroah.com>
References: <200512091848.42297.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512091848.42297.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 06:48:41PM +0100, Blaisorblade wrote:
> Q: Since when is a directory entry allowed to be duplicate?
> A: Since Linux 2.6.14!
> 
> $ uname -r
> 2.6.14.3-bs2-mroute
> 
> The only sysfs-related change is the use of a custom DSDT, which is new to 
> this kernel.

Known bug, fixed in the 2.6.15-rc kernel tree.  It was a timer
registering with the same name in two places :(

And yes, we should have more sysfs checks for stuff like this, any
patches in this area would be greatly appreciated.

thanks,

greg k-h
