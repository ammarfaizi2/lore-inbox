Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUBBDVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 22:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUBBDVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 22:21:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:5050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265590AbUBBDVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 22:21:22 -0500
Date: Sun, 1 Feb 2004 19:16:12 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: hal daemon and ide-floppy
Message-ID: <20040202031612.GA20455@kroah.com>
References: <20040126215036.GA6906@kroah.com> <20040201225224.GA4001@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201225224.GA4001@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 11:52:24PM +0100, J.A. Magallon wrote:
> Hi all...
> 
> It looks like haldaemon is polling my zip to see inserted disks
> (it is the only hadware I have that uses ide-floppy).
> I get a message like this
> 
> Feb  1 23:50:15 werewolf kernel: ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
> Feb  1 23:50:15 werewolf kernel: ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
> Feb  1 23:50:15 werewolf kernel: hdd: No disk in drive
> 
> every 2 seconds, both in messages and syslog.
> They can grow very large after some uptime ;)

Why not ask the hal authors about why they are doing this?

> What is the policy here ? Kill the message in ide-floppy.c ?
> I suppose there can be some other similat messages around there...

You might want to rate-limit those kernel messages though, that's not
very nice to be able to do from userspace.

thanks,

greg k-h
