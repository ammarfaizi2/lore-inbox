Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbULMVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbULMVIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULMVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:08:49 -0500
Received: from waste.org ([209.173.204.2]:30938 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261340AbULMVIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:08:15 -0500
Date: Mon, 13 Dec 2004 13:07:33 -0800
From: Matt Mackall <mpm@selenic.com>
To: Arne Caspari <arne@datafloater.de>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] drivers/base/driver.c : driver_unregister
Message-ID: <20041213210733.GD12189@waste.org>
References: <41BB4268.8020908@datafloater.de> <20041211191113.A13985@flint.arm.linux.org.uk> <41BB4951.2080304@datafloater.de> <41BD42E6.6000402@datafloater.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BD42E6.6000402@datafloater.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 08:21:10AM +0100, Arne Caspari wrote:
> Arne Caspari wrote:
> >Russell King wrote:
> >>No.  The semaphore is there to ensure that the function does not
> >>return until the driver structure has a use count of zero.  If you
> >>tested your patch, you'd find that your change would deadlock on
> >>the locked semaphore.
> >
> >I am sorry I can not test that patch since unloading of the modules I am 
> >currently testing blocks anyway. This makes it very hard to test the 
> >patch :-( and currently this was the reason why I was going to this.
> 
> I reverted the code to the original 2.6.9 and unloading of IEEE1394 
> modules like 'eth1394' does just that: It deadlocks on this semaphore.
> 
> At least this is a good excuse why I was not able to test my patch ;-) 
> The behaviour just remained the same as before...
> 
> Btw. I am developing/debugging on a machine without serial/parallel 
> ports. Is there a way to connect a kernel mode debugger to this. I am 
> used to windows development and there the debugger works on a IEEE1394 
> connection. Does anybody have hints to improve development on such a 
> machine?

Netconsole, and/or kgdb-over-ethernet? You'll need a -mm or -tiny
kernel for the latter, or just pull the patches individually.

-- 
Mathematics is the supreme nostalgia of our time.
