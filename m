Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVBJSpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVBJSpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVBJSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:45:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17160 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261239AbVBJSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:45:13 -0500
Date: Thu, 10 Feb 2005 18:45:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, rml@novell.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] add driver matching priorities
Message-ID: <20050210184508.B5800@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <abelay@novell.com>, Greg KH <greg@kroah.com>,
	rml@novell.com, linux-kernel@vger.kernel.org
References: <1106951404.29709.20.camel@localhost.localdomain> <20050210084113.GZ32727@kroah.com> <1108055918.3423.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1108055918.3423.23.camel@localhost.localdomain>; from abelay@novell.com on Thu, Feb 10, 2005 at 12:18:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> > I think the issue that Al raises about drivers grabbing devices, and
> > then trying to unbind them might be a real problem.
> 
> I agree.  Do you think registering every in-kernel driver before probing
> hardware would solve this problem?

In which case, consider whether we should be tainting the kernel if
someone loads a device driver, it binds to a device, and then they
unload that driver.

It's precisely the same situation, and precisely the same mechanics
as what I've suggested should be going on here.  If one scenario is
inherently buggy, so is the other.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
