Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVAFBGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVAFBGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVAFBGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:06:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51654 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262688AbVAFBGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:06:08 -0500
Subject: Re: 2.6.10-mm1 panic in sysfs ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050105165241.481473a3.akpm@osdl.org>
References: <1104946602.4000.22.camel@dyn318077bld.beaverton.ibm.com>
	 <20050105165241.481473a3.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1104971974.4000.25.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jan 2005 16:39:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 16:52, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > I get a panic in sysfs_readdir() while booting 2.6.10-mm1
> > kernel. Known fixes ?
> > 
> 
> It's news to me.
> 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000020
> >  printing eip:
> > c109c8ef
> > *pde = 0191c001
> > Oops: 0000 [#1]
> > SMP
> > Modules linked in:
> > CPU:    2
> > EIP:    0060:[<c109c8ef>]    Not tainted VLI
> > EFLAGS: 00010282   (2.6.10-mm1kexec)
> 
> What is "2.6.10mm1kexec"?

I enabled kexec in the kernel, so added "kexec" in the EXTRA VERSION.

> 
> > EIP is at sysfs_readdir+0xef/0x280
> > eax: 00000000   ebx: c15e1160   ecx: 0000000c   edx: 00000020
> > esi: c15e1164   edi: c15dd72d   ebp: c1a7df78   esp: c1a7df3c
> > ds: 007b   es: 007b   ss: 0068
> > Process getcfg (pid: 1927, threadinfo=c1a7c000 task=c2ba3040)
> 
> Try to work out what arguments are being passed to `getcfg', then run it by
> hand, under strace, to see what /sysfs file is being accessed when it oopses.

Sure. will do and let you know.

Thanks,
Badari

