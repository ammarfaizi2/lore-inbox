Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272335AbTHNXQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 19:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275054AbTHNXQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 19:16:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:52432 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272335AbTHNXQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 19:16:07 -0400
Date: Thu, 14 Aug 2003 16:16:20 -0700
From: Greg KH <greg@kroah.com>
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBDEV updates.
Message-ID: <20030814231620.GA4632@kroah.com>
References: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org> <20030814203658.GE7862@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814203658.GE7862@guug.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 02:36:58PM -0600, Otto Solares wrote:
> 
> Is there an API (or lib) to use framebuffers devices without
> worring about differents visuals?, to quering, setting or
> disabling EDID support? will these drivers export sysfs
> entries instead of control via ioctl's?

I have some initial sysfs patches for the fb code that I've been sitting
on in my trees.  I was waiting for these patches to hit the mainline
before bothering James and the rest of the world with them.

But they don't export any of the ioctl stuff through the sysfs
interface, but that would not be very hard to do at all if you want to.
They just basically show the major/minor of the fb device, and point
back to the proper place in the device tree where the fb device lives,
which is all udev really needs right now.

thanks,

greg k-h
