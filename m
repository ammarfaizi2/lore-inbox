Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUHETX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUHETX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUHETUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:20:42 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:1951 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267873AbUHETSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:18:54 -0400
Subject: Re: [Fastboot] RE: [BROKEN PATCH] kexec for ia64
From: Khalid Aziz <khalid.aziz@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Randy Dunlap <rddunlap@osdl.org>,
       Linux ia64 <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, fastboot@osdl.org
In-Reply-To: <m1vffxh5xe.fsf@ebiederm.dsl.xmission.com>
References: <200407261524.40804.jbarnes@engr.sgi.com>
	 <20040730155504.2a51b1fa.rddunlap@osdl.org>
	 <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
	 <B8E391BBE9FE384DAA4C5C003888BE6F01CB2705@scsmsx401.amr.corp.intel.com>
	 <m1vffxh5xe.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Message-Id: <1091733511.23589.86.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 13:18:32 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 11:05, Eric W. Biederman wrote:
> Hmm. Your mailer did not add any references lines.
> 
> 
> "Luck, Tony" <tony.luck@intel.com> writes:
> 
> > Jesse Barnes wrote:
> > >With the addition of some ACPI tables and such.  I don't think 
> > >those are freed by the kernel right now though, so it should
> > >be pretty easy to point at the originals from the newly kexec'd
> > >kernel, or make copies.
> > 
> > The "trim_bottom" and "trim_top" functions currently modify
> > the memory map in place.  But this would only make a difference
> > if you tried to kexec a kernel with a smaller granule size than
> > the originally running kernel, and even then would only
> > result in missing seeing some memory that you might have been
> > able to use.
> 
> On x86 and x86-64 we can recover the memory map from /proc/iomem.
> 
> Does that work on ia64?  Can that be fixed to work on ia64?

No, it does not work on ia64. Once I have basic code in place to get
somewhat working kexec on ia64, I am considering looking into fixing
/proc/iomem.

> 
> All of that information needs to get exported to user space so
> /sbin/kexec can pass it to the new kernel.
> 
> Eric

-- 
Khalid

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid_aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini


