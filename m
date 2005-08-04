Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVHDW4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVHDW4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVHDWxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:53:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262753AbVHDWxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:53:16 -0400
Date: Thu, 4 Aug 2005 15:55:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: robert.moore@intel.com, tk-shockwave@web.de, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.13-rc3-mm3
Message-Id: <20050804155513.727a3894.akpm@osdl.org>
In-Reply-To: <42EAC9DB.9010702@gmail.com>
References: <971FCB6690CD0E4898387DBF7552B90E023F8527@orsmsx403.amr.corp.intel.com>
	<42EAC9DB.9010702@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke <iogl64nx@gmail.com> wrote:
>
> Moore, Robert schrieb:
> 
> >+    ACPI-0287: *** Error: Region SystemMemory(0) has no handler
> >+    ACPI-0127: *** Error: acpi_load_tables: Could not load namespace:
> >AE_NOT_EXIST
> >+    ACPI-0136: *** Error: acpi_load_tables: Could not load tables:
> >
> >This looks like a nasty case where some executable code in the table is
> >attempting to access a SystemMemory operation region before any OpRegion
> >handlers are initialized.
> >
> >We certainly want to see the output of acpidump to attempt to diagnose
> >and/or reproduce the problem.
> >
> >Bob
> >
> >
> >  
> >
> Sorry for double post.
> 
> With this mail I hand over the acpidump output with the pmtools
> Andrew pointed me to.
> 
> And a dmesg output with CONFIG_KALLSYMS=y.
> 
> 
> I attached them in bz2 format, because of the length.
> 
> I hope we find the problem.
> 

Michael, I'm assuming that a) this problem remains in those -mm kernels
which include git-acpi.patch and that b) the problems are not present in
2.6.13-rc5 or 2.6.13-rc6, yes?

So I think we have a bug in git-acpi.patch?

If that's all correct then can you please test the next -mm (which will
include git-acpi.patch - the most recent -mm did not) and if the bug's
still there can you raise a bugzilla.kernel.org entry for it?

We seem to have a handful of bug reports against the -mm acpi patch.

Thanks.
