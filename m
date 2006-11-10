Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424378AbWKJH4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424378AbWKJH4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 02:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424379AbWKJH4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 02:56:46 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:61192 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1424378AbWKJH4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 02:56:46 -0500
Date: Fri, 10 Nov 2006 07:56:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
Message-ID: <20061110075640.GA15611@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com> <200611092317.26459.s0348365@sms.ed.ac.uk> <m1ejsbnagm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejsbnagm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:21:13PM -0700, Eric W. Biederman wrote:
> Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:
> > Eric, do you have a list of the remaining users? It'd be good to know for 
> > people using Linux in an embedded environment, where they may want to switch 
> > off the option, but only if it doesn't break their userspace.
> 
> They are very very few.  The ones I recall are kudzu, radvd, and
> libpthreads (which doesn't care).  

Let's not forget that on ARM it's used to get the MMIO region which
is used for PIO emulation by glibc.  Without it, glibc can't detect
where this region is.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
