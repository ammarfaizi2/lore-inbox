Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269557AbUJFVCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbUJFVCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269570AbUJFU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:59:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:20900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269557AbUJFUzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:55:46 -0400
Date: Wed, 6 Oct 2004 13:54:18 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006205417.GA25437@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com> <1097090333.29706.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097090333.29706.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 08:18:54PM +0100, Alan Cox wrote:
> On Mer, 2004-10-06 at 18:41, Greg KH wrote:
> > Good point.  So, should we do it in the kernel, in call_usermodehelper,
> > so that all users of this function get it correct, or should I do it in
> > userspace, in the /sbin/hotplug program?
> > 
> > Any opinions?
> 
> Userspace is more flexible. What does the kernel do if it can't figure
> out what to open as fd 0, 1, 2. Either it explodes or asks user space.
> While /sbin/hotplug can mknod itself a private /dev/null and
> /dev/console in an emergency.

Ok, then anyone with some serious bash-foo care to send me a patch for
the existing /sbin/hotplug file that causes it to handle this properly?

thanks,

greg k-h
