Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWI2Xie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWI2Xie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWI2Xie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:38:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030200AbWI2Xid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:38:33 -0400
Date: Fri, 29 Sep 2006 16:38:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: len.brown@intel.com, Martin Bligh <mbligh@google.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Fix up a multitude of ACPI compiler warnings on x86_64
Message-Id: <20060929163827.d77a12c8.akpm@osdl.org>
In-Reply-To: <20060929161852.4b6ae44a.rdunlap@xenotime.net>
References: <451D9236.6040902@google.com>
	<20060929150526.38eec941.akpm@osdl.org>
	<20060929161852.4b6ae44a.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 16:18:52 -0700
Randy Dunlap <rdunlap@xenotime.net> wrote:

> > 
> > acpi-fix-printk-format-warnings.patch was submitted to the ACPI developers
> > on August 14 and on September 25 but remains unmerged.
> 
> Len and I discussed that patch some.  The question about it is:
> why does gcc report this at all?  Is this a gcc problem or are
> we misreading it somehow?
> 
>  drivers/acpi/tables/tbget.c: In function 'acpi_tb_get_this_table':
> drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
> 
> drivers/acpi/tables/tbrsdt.c: In function 'acpi_tb_validate_rsdt':
> drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
> 
> Why does it think that sizeof(struct X) is long unsigned int?
> (and only on 64-bit)

hm, strange.  No warning at all on 32-bit.

Don't know.  But the patch is correct.
