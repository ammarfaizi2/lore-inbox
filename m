Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270926AbTHAVeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272431AbTHAVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:34:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:9175 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270926AbTHAVeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:34:18 -0400
Date: Fri, 1 Aug 2003 14:27:50 -0700
From: Greg KH <greg@kroah.com>
To: Diffie <diffie@blazebox.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030801212750.GB31881@kroah.com>
References: <20030801182207.GA3759@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801182207.GA3759@blazebox.homeip.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 02:22:07PM -0400, Diffie wrote:
> 
> Under 2.6.0-test2-mm2 keeps getting Badness in device_release at
> drivers/base/core.c:84 when loading USB modules on NFORCE2 based board.
> 
> uname: Linux blaze 2.6.0-test2-mm2 #1 Thu Jul 31 13:11:05 EDT 2003 i686
> unknown on Linux Slackware 9.0, GCC 3.2.2
> 
> Device '' does not have a release() function, it is broken and must be
> fixed.
> Badness in device_release at drivers/base/core.c:84
> Call Trace:
> [<c021dfd8>] kobject_cleanup+0x88/0x90
> [<c02c03ff>] hub_port_connect_change+0x2af/0x330
> [<c02bfcfd>] hub_port_status+0x3d/0xb0
> [<c02c07bd>] hub_events+0x33d/0x3b0
> [<c02c0865>] hub_thread+0x35/0xf0
> [<c011b810>] default_wake_function+0x0/0x30
> [<c02c0830>] hub_thread+0x0/0xf0
> [<c01070c9>] kernel_thread_helper+0x5/0xc

The USB warnings should all be fixed up with the patches I just sent to
Linus, so you can safely ignore them for now.

As for the oops, I have no idea, sorry.

thanks,

greg k-h
