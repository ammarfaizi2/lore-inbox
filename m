Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbULIQsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbULIQsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULIQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:44:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:53426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261558AbULIQnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:43:08 -0500
Date: Thu, 9 Dec 2004 08:37:46 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041209163746.GB12257@kroah.com>
References: <87acsrqval.fsf@coraid.com> <20041206215456.GB10499@kroah.com> <87oeh35v6s.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oeh35v6s.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 10:48:43AM -0500, Ed L Cashin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> ...
> >> +	printk(KERN_INFO "aoe: aoeblk_ioctl: unknown ioctl %d\n", cmd);
> >
> > So I can flood the syslog by sending improper ioctls to the driver?
> > That's not nice...
> 
> Wouldn't root be the only user who could do that?  When would this
> happen?  

Your code is not preventing anyone from calling it.  So any user could.

Now if you are relying on the dev node from having the proper
permissions, that's ok too, but you might want to put a comment in
stating that.

If you aren't relying on the device node to have the proper permissions,
then you need to do a check on capable() here.



thanks,

greg k-h
