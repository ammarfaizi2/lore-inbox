Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947141AbWKKIE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947141AbWKKIE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 03:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947142AbWKKIE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 03:04:56 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:28688 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1947141AbWKKIEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 03:04:55 -0500
Date: Sat, 11 Nov 2006 08:04:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
Message-ID: <20061111080446.GA17861@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com> <200611092317.26459.s0348365@sms.ed.ac.uk> <m1ejsbnagm.fsf@ebiederm.dsl.xmission.com> <20061110075640.GA15611@flint.arm.linux.org.uk> <m11woblnxf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11woblnxf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 01:13:16AM -0700, Eric W. Biederman wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > Let's not forget that on ARM it's used to get the MMIO region which
> > is used for PIO emulation by glibc.  Without it, glibc can't detect
> > where this region is.
> 
> Is that on all subarches or just some of them?

No idea - I don't have that sort of information.  Those which are PCI
based have the potential to use it if some userspace programmer wants
to use the ioperm/inb/outb etc which glibc provides.

I have had the occasional bug report that these functions haven't
worked when we haven't been exporting the right info via sysctl, so
they do seem to get used.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
