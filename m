Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbULVFGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbULVFGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbULVFGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:06:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:22720 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261309AbULVFGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:06:46 -0500
Date: Tue, 21 Dec 2004 21:03:45 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041222050345.GA31076@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <200412201525.52149.oliver@neukum.org> <20041221182514.5ed935e2@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221182514.5ed935e2@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 06:25:14PM -0800, Pete Zaitcev wrote:
> 
> Generally, the type of coding which requires a use of memory barriers in drivers
> is a bug or a latent bug, so I am sorry for the above. It was a sacrifice to
> make usbmon invisible if it's not actively monitoring. Sorry about that.

Well, why do that?  Why not do something like the security hooks do, and
have a default "noop" hook if we don't have a monitor, and when you load
the monitor, it switches the hook to point to your code?

thanks,

greg k-h
