Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTDKVnz (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTDKVnz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:43:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31655 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261760AbTDKVnv (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:43:51 -0400
Date: Fri, 11 Apr 2003 14:57:55 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411215755.GX1821@kroah.com>
References: <20030411204329.GT1821@kroah.com> <200304112111.h3BLBWgu025834@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304112111.h3BLBWgu025834@post.webmailer.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:09:03PM +0200, Arnd Bergmann wrote:
> 
> - Someone accidentally removes the cable that connects a few hundred 
>   (mounted) disks
> - The cable is replaced, but - oops - to the wrong socket
> - The person notices the error and now places the cable into the right
>   socket.
> 
> At this time we have four concurrent hotplug events for every single
> disks that we want to be finished in order and we want every disk
> to end up with its original minor number in the end. If this is not
> possible, the system still needs to be in a sensible state after this.

No, you want to make sure you have the same "name" after that.  As any
userspace apps that had a open file on the original disks are basically
screwed anyway, we want a way to enable them to recover nicely.

And no, I don't want to go into the whole, remove a device and plug it
back in, and userspace never noticed the difference while it held an
open file handle.  That's a problem I don't want to even go near right
now, and is totally different from what udev is trying to do :)

thanks,

greg k-h
