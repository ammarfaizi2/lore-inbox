Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUATIWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUATIWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:22:38 -0500
Received: from dp.samba.org ([66.70.73.150]:11692 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265221AbUATIWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:22:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
       Brian King <brking@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       kai@germaschewski.name, sam@ravnborg.org, akpm@osdl.org
Subject: Re: Question on MODULE_VERSION macro 
In-reply-to: Your message of "Mon, 19 Jan 2004 17:17:34 -0800."
             <20040120011734.GB6309@kroah.com> 
Date: Tue, 20 Jan 2004 18:47:56 +1100
Message-Id: <20040120082232.C9AFE2C290@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120011734.GB6309@kroah.com> you write:
> On Tue, Jan 20, 2004 at 11:57:38AM +1100, Rusty Russell wrote:
> > In message <20040119214233.GF967@beaverton.ibm.com> you write:
> > > Rusty,
> > > 	Christoph mentioned that a MODULE_VERSION macro may be pending.
> > 
> > Hey, thanks Christoph for the reminder.  I stopped when we were
> > frozen.
> > 
> > This still seems to apply.  Do people think this is huge overkill, or
> > a work of obvious beauty and genius?
> 
> Looks sane.  I'm guessing that modinfo can show this?

Yes.  Looks like so:

--- working-2.6.1-bk5-module_version/arch/i386/kernel/apm.c.~1~	2003-09-29 10:25:15.000000000 +1000
+++ working-2.6.1-bk5-module_version/arch/i386/kernel/apm.c	2004-01-20 18:22:46.000000000 +1100
@@ -2081,3 +2081,4 @@
 MODULE_PARM_DESC(smp,
 	"Set this to enable APM use on an SMP platform. Use with caution on older systems");
 MODULE_ALIAS_MISCDEV(APM_MINOR_DEV);
+MODULE_VERSION("1.16ac-rustytest");

$ modinfo arch/i386/kernel/apm.ko
author:         Stephen Rothwell
description:    Advanced Power Management
license:        GPL
....
version:        1.16ac-rustytest B13E9451C4CA3B89577DEFF
vermagic:       2.6.1-bk5 SMP PENTIUMII gcc-3.2
depends:        

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
