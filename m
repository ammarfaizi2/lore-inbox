Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVAOB16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVAOB16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVAOBYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:24:46 -0500
Received: from [220.248.27.114] ([220.248.27.114]:47259 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262115AbVAOBXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:23:33 -0500
Date: Sat, 15 Jan 2005 09:21:20 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: qemu-devel@nongnu.org
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Message-ID: <20050115012120.GA4743@hugang.soulinfo.com>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501131909.26021.rjw@sisk.pl> <20050114143400.GA27657@hugang.soulinfo.com> <200501150042.35377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501150042.35377.rjw@sisk.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 12:42:35AM +0100, Rafael J. Wysocki wrote:
> On Friday, 14 of January 2005 15:34, you wrote:
> > On Thu, Jan 13, 2005 at 07:09:24PM +0100, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > 
> > > Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> > > or an alternative?
> > > 
> > 
> > Ok, Here is a new patch with x86_64 support, But I have not machine, So
> > Need someone test it. 
> > 
> > 2.6.11-rc1-mm1 
> >  -> 2005-1-14.core.diff 	core patch		TEST PASSED
> >   -> 2005-1-14.x86_64.diff	x86_64 patch	NOT TESTED
> 
> Unfortunately, on x86_64 it goes south on suspend, probably somwhere in write_pagedir(),
> but I'm not quite sure as I can't make it print any useful stuff to the serial console
> (everything is dumped to a virtual tty only).  Seemingly, it prints some
> "write_pagedir: ..." debug messages and then starts to print garbage in
> an infinite loop.

Try enable debug in swsusp, 
<....>
#include "power.h"
#undef pr_debug
#define pr_debug printk
<....>

 Enable serial conosole, 
 Adding console=ttyS0 in boot command line.

Then do software suspend, And send the log to me, that will useful. 

For other reference, I using qemu As X86-64 emulation, But current qemu
X86-64 not full works, the kernel hang after copy_page in suspend, I'll
enable CPU and ASM log in qemu to finger other where is the problem.

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
