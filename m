Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbTEEA32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 20:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEEA32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 20:29:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261854AbTEEA31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 20:29:27 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Date: 4 May 2003 17:41:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b94bvv$pok$1@cesium.transmeta.com>
References: <200305041027_MC3-1-3758-4298@compuserve.com> <20030504222227.GB6808@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030504222227.GB6808@twiddle.net>
By author:    Richard Henderson <rth@twiddle.net>
In newsgroup: linux.dev.kernel
>
> On Sun, May 04, 2003 at 10:25:26AM -0400, Chuck Ebbert wrote:
> > asmlinkage int sys_iopl(unsigned long unused)
> > {
> >         struct pt_regs * regs = (struct pt_regs *) &unused;       <== yuck!
> [...]
> >   Shouldnt it be like this?
> > 
> > asmlinkage int sys_iopl (struct pt_regs regs)
> 
> No, it should be like 
> 
>   int sys_iopl (struct pt_regs *regs)
> 
> and assembly language should push the proper address.
> 
> The struct-as-argument form allows the compiler to
> smash the entire structure as it sees fit.
> 

Hardly - it has to correspond to the ABI for the platform."

Presumably that's where the "asmlinkage" piece comes in.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
