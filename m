Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVAYF5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVAYF5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 00:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVAYF5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 00:57:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:44507 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261825AbVAYF5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 00:57:01 -0500
Date: Mon, 24 Jan 2005 21:56:51 -0800
From: Greg KH <greg@kroah.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
Message-ID: <20050125055651.GA1987@kroah.com>
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 07:25:19PM +0100, Jirka Kosina wrote:
> Hi,
> 
> there has been (for quite some time) a bug in function driver_unregister() 
> - the lock/unlock sequence is protecting nothing and the actual 
> bus_remove_driver() is called outside critical section.
> 
> Please apply.

No, please read the comment in the code about why this is the way it is.
The code is correct as is.

Also, please CC the driver core maintainer next time for patches like
this so I don't miss them when they go by.

thanks,

greg k-h
