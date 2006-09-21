Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWIUQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWIUQZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWIUQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:25:51 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:25866 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751305AbWIUQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:25:51 -0400
Date: Thu, 21 Sep 2006 17:25:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: AUDIT=y build failure on ARM
Message-ID: <20060921162543.GA29714@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk
References: <20060920124908.GA30389@deprecation.cyrius.com> <200609211144.k8LBiGjY018080@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609211144.k8LBiGjY018080@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 07:44:16AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 20 Sep 2006 14:49:08 +0200, Martin Michlmayr said:
> > I get the build failure below with AUDIT=y on ARM.  The problem is
> > that lib/audit.c includes asm-generic/audit_dir_write.h which lists a
> > number of syscalls that are not defined on ARM (and some other platforms).
> 
> And somebody (I forget who) was complaining that some debugging tool was only available
> on the x86/sparc/ppc families of CPUs, and didn't like Alan Cox's suggestion
> that they go add it.
> 
> Given that missing an entire class of syscall (the *at flavors) on an
> architecture isn't a deterrent to inclusion, Alan's response was totally
> on-target....
> 
> (I'm presuming the usual reason for such missing syscalls is that nobody
> has bothered trying to run software that uses a *at call on an ARM, so
> nobody's bothered wiring them up and thereby increasing the kernel image
> size on a platform where it's likely to be *very* important?)

They probably should be wired up, but TBH I _always_ miss the addition
of such things.  I don't remember there being any notification to arch
maintainers that something was due to be done.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
