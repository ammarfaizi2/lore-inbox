Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVDDXyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVDDXyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDDXxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:53:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12297 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261525AbVDDXt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:49:59 -0400
Date: Tue, 5 Apr 2005 00:49:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc2
Message-ID: <20050405004955.A4370@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org> <20050404232419.GA8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050404232419.GA8859@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Tue, Apr 05, 2005 at 12:24:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:24:19AM +0100, Al Viro wrote:
> On Mon, Apr 04, 2005 at 02:32:52PM -0700, Linus Torvalds wrote:
> > This is also the point where I ask people to calm down, and not send me
> > anything but clear bug-fixes etc. We're definitely well into -rc land. So 
> > keep it quiet out there,
> 
> 	* missing include in arm/kernel/time.c - see #ifdef CONFIG_PM
> further down in the file.

See previous threads.

The include should be in linux/sysdev.h.  The reason this has come up is
because the ARM changes got merged before the generic changes, so there's
currently a minor disparity with the calling convention for system
device suspend methods.

IOW, when sysdev.h is updated to prototype the function pointer with
pm_message_t, this'll also be solved.

Therefore, if anything, linux/pm.h should be added to linux/sysdev.h as
the minimal patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
