Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUJFRmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUJFRmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269318AbUJFRmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:42:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:37298 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269310AbUJFRmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:42:20 -0400
Date: Wed, 6 Oct 2004 10:41:08 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006174108.GA26797@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097074822.29251.51.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 04:00:23PM +0100, Alan Cox wrote:
> On Maw, 2004-10-05 at 22:13, Russell King wrote:
> > I'm redirecting them in the /sbin/hotplug script to something sane,
> > but I think the kernel itself should be directing these three fd's
> > to somewhere whenever it invokes any user program, even if it is
> > /dev/null.
> 
> Someone should yes. There are lots of fascinating things happen when
> hotplug opens a system file, it gets assigned fd 2 and then we write to
> stderr.

Good point.  So, should we do it in the kernel, in call_usermodehelper,
so that all users of this function get it correct, or should I do it in
userspace, in the /sbin/hotplug program?

Any opinions?

thanks,

greg k-h
