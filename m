Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWGIE6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWGIE6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 00:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWGIE6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 00:58:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964977AbWGIE6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 00:58:39 -0400
Date: Sat, 8 Jul 2006 21:58:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: mreuther@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: Compile Error on 2.6.17-mm6
Message-Id: <20060708215836.b8b3337b.akpm@osdl.org>
In-Reply-To: <20060708213734.a204a044.rdunlap@xenotime.net>
References: <200607072222.31586.mreuther@umich.edu>
	<20060708174347.76391c7b.akpm@osdl.org>
	<20060708203424.281400d2.rdunlap@xenotime.net>
	<20060708204448.6914aaf9.akpm@osdl.org>
	<20060708213734.a204a044.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006 21:37:34 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Sat, 8 Jul 2006 20:44:48 -0700 Andrew Morton wrote:
> 
> > On Sat, 8 Jul 2006 20:34:24 -0700
> > "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > 
> > > On Sat, 8 Jul 2006 17:43:47 -0700 Andrew Morton wrote:
> > > 
> > > > On Fri, 7 Jul 2006 22:22:16 -0400
> > > > Matt Reuther <mreuther@umich.edu> wrote:
> > > > 
> > > > > Here is the error:
> > > > >   CHK     include/linux/compile.h
> > > > >   UPD     include/linux/compile.h
> > > > >   CC      init/version.o
> > > > >   LD      init/built-in.o
> > > > >   LD      .tmp_vmlinux1
> > > > > arch/i386/kernel/built-in.o(.text+0xe282): In function 
> > > > > `cpu_request_microcode':
> > > > > arch/i386/kernel/microcode.c:544: undefined reference to `request_firmware'
> > > > > arch/i386/kernel/built-in.o(.text+0xe304):arch/i386/kernel/microcode.c:573: 
> > > > > undefined reference to `release_firmware'
> > > > 
> > > > CONFIG_FW_LOADER=m
> > > > CONFIG_MICROCODE=y
> > > > 
> > > > So
> > > > 
> > > > config MICROCODE
> > > > 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
> > > > 	depends on FW_LOADER
> > > > 
> > > > is not sufficient.  There's a fix for this, but I cannot remember what it
> > > > is.  Help.
> > > 
> > > That 1-line depends patch fixes the problem for me (on x86-64,
> > > but they are the same in this area).
> > > 
> > 
> > What patch is that?
> 
> My -mm6 does not have "depends on FW_LOADER" like you wrote above,
> so I thought that you had added that 1-line as a patch.
> 

Oh, OK, yes, I fixed that post-2.6.17-mm6.

>  arch/x86_64/Kconfig |    1 +

Although I missed x86_64.

