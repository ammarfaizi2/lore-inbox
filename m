Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWATXSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWATXSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWATXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:18:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8200 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751186AbWATXSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:18:05 -0500
Date: Fri, 20 Jan 2006 23:17:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Loftis <mloftis@wgops.com>
Cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120231757.GB20148@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Marc Koschewski <marc@osknowledge.org>,
	linux-kernel@vger.kernel.org
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr> <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com> <20060120194331.GA8704@kroah.com> <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 01:56:12PM -0700, Michael Loftis wrote:
> A decent amount of ARM stuff moving around between even just 2.6.11 
> and 2.6.13 (admittedly that's a gripe for ARM) making development for that 
> port very painful

What you're complaining about here seems to be:

1. the cleanup of the entry and debug code - TRIVIAL - it's a
   cut-n-paste job.  No interface change.  Estimated time to
   resolve: 5 minutes
2. moving the machine specific boot makefile parameters into
   arch/arm/mach-* - TRIVIAL - it's a cut-n-paste job.  No interface
   change.  Estimated time to resolve: 5 minutes.
3. removing messy macros for the machine description.  Slightly less
   trivial because you need to do some investigation and then an
   exercise of about 10 subsitutions in one file.  Estimated time
   to resolve: 30 minutes.

All changes listed above to lower the long term maintainence burden of
the kernel _and_ make it easier to port to new SoCs.

Ok, so, let's be generous - call it one hour.  Are you _really_ griping
about one hour's work on your part being "very painful"?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
