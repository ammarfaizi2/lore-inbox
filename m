Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVAXTDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVAXTDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVAXTCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:02:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:4276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261569AbVAXTBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:01:01 -0500
Date: Mon, 24 Jan 2005 11:00:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
Message-ID: <20050124110059.W469@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>; from jikos@jikos.cz on Mon, Jan 24, 2005 at 07:25:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jirka Kosina (jikos@jikos.cz) wrote:
> there has been (for quite some time) a bug in function driver_unregister() 
> - the lock/unlock sequence is protecting nothing and the actual 
> bus_remove_driver() is called outside critical section.

Re-read the comment.  It's intentionally done that way.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
