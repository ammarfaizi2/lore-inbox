Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUJEVHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUJEVHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJEVHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:07:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:23705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265161AbUJEVHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:07:39 -0400
Date: Tue, 5 Oct 2004 14:06:59 -0700
From: Greg KH <greg@kroah.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041005210659.GA5276@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005212712.I6910@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 09:27:12PM +0100, Russell King wrote:
> On Tue, Oct 05, 2004 at 08:52:14PM +0200, J?rn Engel wrote:
> > Looks pretty trivial, but opinions on this subject may vary.
> > Comments?
> 
> There's a related problem.  /sbin/hotplug.  I keep seeing odd failures
> from /sbin/hotplug scripts which go away when I ensure that fd0,1,2 are
> directed at something real.

Which scripts cause this problem?

> It's rather annoying because it currently means that, when my PCMCIA net
> interface on the firewall comes up, the IPv4 configuration works fine
> but IPv6 configuration falls dead on its nose without any explaination
> why.
> 
> And, like I say, redirecting fd0,1,2 fixes it.

Redirecting it in the script itself?  Or in the kernel like this patch?

thanks,

greg k-h
