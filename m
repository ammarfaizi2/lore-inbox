Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVBJVms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVBJVms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVBJVms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:42:48 -0500
Received: from peabody.ximian.com ([130.57.169.10]:62149 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261682AbVBJVmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:42:37 -0500
Subject: Re: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050210184508.B5800@flint.arm.linux.org.uk>
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <20050210084113.GZ32727@kroah.com>
	 <1108055918.3423.23.camel@localhost.localdomain>
	 <20050210184508.B5800@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 16:37:03 -0500
Message-Id: <1108071423.3423.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 18:45 +0000, Russell King wrote:
> On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> > > I think the issue that Al raises about drivers grabbing devices, and
> > > then trying to unbind them might be a real problem.
> > 
> > I agree.  Do you think registering every in-kernel driver before probing
> > hardware would solve this problem?
> 
> In which case, consider whether we should be tainting the kernel if
> someone loads a device driver, it binds to a device, and then they
> unload that driver.
> 
> It's precisely the same situation, and precisely the same mechanics
> as what I've suggested should be going on here.  If one scenario is
> inherently buggy, so is the other.
> 

I think it would depend on whether the user makes the device busy before
the driver is unloaded.  Different device classes may have different
requirements for when and how a device can be removed.  Are there other
issues as well?  Maybe there are ways to improve driver start and stop
mechanics.

Thanks,
Adam


