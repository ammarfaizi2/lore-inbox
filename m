Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUATXbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbUATXbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:31:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:46798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265907AbUATXbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:31:02 -0500
Date: Tue, 20 Jan 2004 15:31:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: grundig@teleline.es, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow DRM on 386
Message-Id: <20040120153158.2c2e47f7.akpm@osdl.org>
In-Reply-To: <20040120230313.GA6441@fs.tum.de>
References: <20040120212421.GF12027@fs.tum.de>
	<20040120234403.73be7b2a.grundig@teleline.es>
	<20040120230313.GA6441@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> On Tue, Jan 20, 2004 at 11:44:03PM +0100, Diego Calleja wrote:
> > El Tue, 20 Jan 2004 22:24:21 +0100 Adrian Bunk <bunk@fs.tum.de> escribió:
> > 
> > > I got the following compile error in 2.6.1-mm5 with X86_CMPXCHG=n.
> > > This problem is not specific to -mm, and it always occurs when you 
> > > include support for the 386 cpu (oposed to the 486 or later cpus) since 
> > > in this case X86_CMPXCHG=n and therefoore cmpxchg isn't defined in 
> > > include/asm-i386/system.h .
> > > 
> > > The patch below disallows DRM if X86_CMPXCHG=n.
> > 
> > I got a "cmpxchg not defined" error when compiling the drm stuff in -mm5.
> > When I looked at the configuration, I saw that all the cpus types had been selected
> > (I didn't even realize of your stuuf and menuconfig put the defaults). I removed
> > all types of cpus except PIII and it compiled.
> 
> Yup, that's exactly the problem.
> 
> Selecting CPU_386 in -mm4 or -mm5 or selecting M386 in other kernels 
> triggers it.
> 

I'll remove 386 from the default CPU types as well.

