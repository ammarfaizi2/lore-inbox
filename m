Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbUKEBDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbUKEBDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbUKEBDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:03:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3827 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262527AbUKEBBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:01:17 -0500
Date: Thu, 4 Nov 2004 19:01:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
Message-ID: <20041105010112.GC3792@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <20041104145229.D2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104145229.D2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quoting Chris Wright (chrisw@osdl.org):
...
> I think, all in all, this needs more work and more justification (esp.
> w.r.t. overhead and impact on the current common use of a single
> module).

Would it help to make CONFIG_NUM_LSMS a boot time option, and default
to 1?

As for justification, the fact that many LSMS currently cannot be
used simultaneously seemed the most prominent.  It certainly seems viable
to use SELinux to protect audit logs and shadow files, use bsdjail to
offer certain services, and use securelevel for some generic hardening,
for instance.

> > 2. A 2.6.10-rc1-bk10 system with the stacking patches, and capabilities
> > and SELinux compiled into the kernel under the stacker LSM.  Other
> > than stacker being compiled in and the size of the LSM void* array
> > being set to 4, the exact same .config was used.
> 
> How many CPU's?

This was one cpu.  (All I have available at the moment)

> How did lmbench numbers look?  And other workloads, like network?

I will run lmbench tomorrow, and look for some network benchmark.

thanks,
-serge
