Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbUKWHs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbUKWHs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUKWHs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:48:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:27109 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262317AbUKWHqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:46:06 -0500
Date: Mon, 22 Nov 2004 23:45:51 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Message-ID: <20041123074551.GC23194@kroah.com>
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com> <20041122714.9zlcKGKvXlpga8EP@topspin.com> <20041122225033.GD15634@kroah.com> <52oehpbi2j.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52oehpbi2j.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 03:05:40PM -0800, Roland Dreier wrote:
>     Greg> You are letting any user, with any privilege register or
>     Greg> unregister an "agent"?
> 
> They have to be able to open the device node.  We could add a check
> that they have it open for writing but there's not really much point
> in opening this device read-only.

Ok, I remember this conversation a while ago.  We discussed this same
thing a number of months back on the openib mailing list.  Nevermind :)

>     Greg> Also, these "agents" seem to be a type of filter, right?  Is
>     Greg> there no other way to implement this than an ioctl?
> 
> ioctl seems to be the least bad way to me.  This really feels like a
> legitimate use of ioctl to me -- we use read/write to handle passing
> data through our file descriptor, and ioctl for control of the
> properties of the descriptor.
> 
> What would you suggest as an ioctl replacement?

I really can't think of anything else.  It just will require a _lot_ of
vigilant attention to prevent people from adding other ioctls to this
one, right?

Do you have other ioctls planned for this same interface for stage 2 and
future stages of ib implementation for Linux?

thanks,

greg k-h
