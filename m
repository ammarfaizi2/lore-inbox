Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWEDVRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWEDVRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWEDVRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:17:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34503 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751343AbWEDVRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:17:04 -0400
Date: Thu, 4 May 2006 23:17:03 +0200
From: Martin Mares <mj@ucw.cz>
To: Peter Jones <pjones@redhat.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <mj+md-20060504.211425.25445.atrey@ucw.cz>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <200605041309.53910.bjorn.helgaas@hp.com> <445A51F1.9040500@linux.intel.com> <200605041326.36518.bjorn.helgaas@hp.com> <E1FbjiL-0001B9-00@chiark.greenend.org.uk> <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com> <1146776736.27727.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146776736.27727.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > This is yet another way that user space can mess up the kernel. If VGA
> > routing is changes under fbdev (my attribute notifies fbdev, the fbdev
> > code for processing the notification did get checked in) then the
> > console will screw up.
> 
> And this change allows userland to avoid doing that.

Could you explain how?  I don't see how adding a "enable" attribute
to sysfs can solve these problems.

I agree with Arjan that the attribute could be useful for some special
tools, but using it in X is likely to be utterly wrong.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A mathematician is a machine for converting coffee into theorems.
