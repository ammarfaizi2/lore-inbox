Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUJFSUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUJFSUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJFSUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:20:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:24773 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269351AbUJFSU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:20:26 -0400
Date: Wed, 6 Oct 2004 11:18:36 -0700
From: Greg KH <greg@kroah.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006181836.GA27300@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com> <20041006180145.GC10153@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006180145.GC10153@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 08:01:45PM +0200, J?rn Engel wrote:
> On Wed, 6 October 2004 10:41:08 -0700, Greg KH wrote:
> > 
> > Good point.  So, should we do it in the kernel, in call_usermodehelper,
> > so that all users of this function get it correct, or should I do it in
> > userspace, in the /sbin/hotplug program?
> > 
> > Any opinions?
> 
> Kernel.
> 
> Same reasoning as before, if someone comes along and creates a "much
> better" /sbin/hotplug which doesn't handle it, things will break
> again.

Ok, I buy it :)

Care to send a patch to do this?

thanks,

greg k-h
