Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269363AbUJFS1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269363AbUJFS1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUJFS1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:27:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:62387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269360AbUJFS0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:26:11 -0400
Date: Wed, 6 Oct 2004 11:26:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006112609.C2441@build.pdx.osdl.net>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com> <20041006180145.GC10153@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041006180145.GC10153@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Wed, Oct 06, 2004 at 08:01:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jörn Engel (joern@wohnheim.fh-wedel.de) wrote:
> On Wed, 6 October 2004 10:41:08 -0700, Greg KH wrote:
> > 
> > Good point.  So, should we do it in the kernel, in call_usermodehelper,
> > so that all users of this function get it correct, or should I do it in
> > userspace, in the /sbin/hotplug program?
> > 
> > Any opinions?
> 
> Kernel.

I agree.  There's code in the kernel doing that already, but IIRC, it's
only in SELinux.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
