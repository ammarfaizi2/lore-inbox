Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUA0XRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUA0XRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:17:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:35211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263424AbUA0XRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:17:04 -0500
Date: Tue, 27 Jan 2004 15:16:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: ak@muc.de, eric@cisu.net, stoffel@lucent.com, Valdis.Kletnieks@vt.edu,
       bunk@fs.tum.de, cova@ferrara.linux.it, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040127151644.1fb378c2.akpm@osdl.org>
In-Reply-To: <20040127223009.GA81095@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401261326.09903.eric@cisu.net>
	<20040126115614.351393f2.akpm@osdl.org>
	<200401262343.35633.eric@cisu.net>
	<20040126215056.4e891086.akpm@osdl.org>
	<20040127162043.GA98702@colin2.muc.de>
	<20040127125447.31631e14.akpm@osdl.org>
	<20040127223009.GA81095@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> > I've moved the enabling of -funit-at-a-time out of Makefile and down into
> > arch/i386/Makefile, and I changed to require gcc-3.4 or higher.
> > 
> > So if you want to use -funit-at-a-time on gcc-3.3/hammer you can do so.
> 
> Please undo that and apply this patch instead. It fixes the bug that
> broke booting with older gcc 3.3-hammer compilers (confirmed by
> two people on l-k). It was plain luck that it worked with the other
> compilers. 

I'll turn it on for gcc-3.3 and higher.  We can change that if someone has
tested earlier compilers.

Also, I do think this should remain a per-arch decision.  Other
architectures could well have similar problems to this and we don't want to
be mysteriously breaking their kernels for them.

