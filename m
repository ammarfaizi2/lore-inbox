Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbRLRTJx>; Tue, 18 Dec 2001 14:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284795AbRLRTIT>; Tue, 18 Dec 2001 14:08:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284744AbRLRTHh>; Tue, 18 Dec 2001 14:07:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to use >3G memory per process
Date: 18 Dec 2001 11:07:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vo45f$idr$1@cesium.transmeta.com>
In-Reply-To: <OHEPLPGMMIEGHANJIEBAIEPKCEAA.wydeng@platodesign.com> <200112181837.fBIIbUF02685@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200112181837.fBIIbUF02685@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
By author:    Wayne Whitney <whitney@math.berkeley.edu>
In newsgroup: linux.dev.kernel
>
> In mailing-lists.linux-kernel, you wrote:
> 
> > [1] What need to be done for the kernel to support 3.5G or more user
> > address space per process?
> 
> On ia32, change the value of __PAGE_OFFSET (where kernel space starts)
> in include/asm-i386/page.h.  The size of kernel space must be a power
> of 2, so you can change __PAGE_OFFSET from its default of 0xC0000000
> to either 0xE0000000 (reasonable) or 0xF0000000 (overboard ?).
> You must also change the unlabeled value near the top of
> arch/i386/vmlinux.lds to match the value of __PAGE_OFFSET.
> 

Note that this does break the (old) initrd protocol.  Compile your
kernel monolithic.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
