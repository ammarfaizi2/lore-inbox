Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVCYVEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVCYVEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVCYVEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:04:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261804AbVCYVEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:04:08 -0500
Date: Fri, 25 Mar 2005 21:03:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mundt <lethal@linux-sh.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Separate platform device name from platform device number
Message-ID: <20050325210357.D12715@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1110414879646@kroah.com> <11104148792069@kroah.com> <20050325180136.GA4192@linux-sh.org> <20050325181014.GA13436@kroah.com> <20050325183534.GB4192@linux-sh.org> <5c0804da3486a6e735a46220d73c9637@mac.com> <20050325195826.GC4192@linux-sh.org> <20050325202508.A12715@flint.arm.linux.org.uk> <20050325205603.GD4192@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050325205603.GD4192@linux-sh.org>; from lethal@linux-sh.org on Fri, Mar 25, 2005 at 10:56:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 10:56:03PM +0200, Paul Mundt wrote:
> On Fri, Mar 25, 2005 at 08:25:08PM +0000, Russell King wrote:
> > Eh?  How do you end up with "/sys/devices/platform/foobar0.0" for the
> > former case?  It has an ID of "-1", and not zero.  Your idea doesn't
> > make any sense.
> > 
> Yes, I missed the -1 part, so Kyle is correct.
> 
> It would be trivial to treat them both as foobar0 and have the
> registration succeed for whoever gets it first, but I could see that this
> would be problematic in the serial8250 case. On the other hand, this is
> then serial8250's problem.

Thank you for ignoring the other case of i82385 to justify your point
of view of it being just a single driver problem.

Maybe you can work out a patch to fix up this mess?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
