Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUCZSV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZSV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:21:59 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:41113 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S264113AbUCZSUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:20:04 -0500
Date: Fri, 26 Mar 2004 11:19:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm-ppc/elf.h warning
Message-ID: <20040326181945.GA20819@smtp.west.cox.net>
References: <20040326174338.GB17402@smtp.west.cox.net> <Pine.GSO.4.44.0403261956350.2460-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403261956350.2460-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 08:00:06PM +0200, Meelis Roos wrote:

> > Can you try just removing <linux/elf.h> from everything in
> > arch/ppc/boot/ ?
> 
> elf.h include is present in arch/ppc/boot/simple/misc.c and
> arch/ppc/boot/simple/misc-embedded.c. The first one caused my warning
> and the include can be safely removed from there. The other file is not
> used in my config (prep) but I did try to compile it with elf.h include
> removed (make arch/ppc/boot/simple/misc-embedded.o) and it failed. So
> here is the patch against arch/ppc/boot/simple/misc.c.

Ok, I'll look into that myself.

> Nevertheless,
> asm-ppc/elf.h can not be included by itself without a warning about
> struct task_struct - is this a problem or not?

It depends on if (a) other arches have a task_struct-needing extern in
this file and (b) what do they do?  There's at least a few #includes
with implicit #include requirements out there, i _think_.

-- 
Tom Rini
http://gate.crashing.org/~trini/
