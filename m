Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTFSGEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbTFSGEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:04:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265500AbTFSGEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:04:06 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: common name for the kernel DSO
Date: 18 Jun 2003 23:18:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bcrkiq$dta$1@cesium.transmeta.com>
References: <16112.47509.643668.116939@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16112.47509.643668.116939@napali.hpl.hp.com>
By author:    David Mosberger <davidm@napali.hpl.hp.com>
In newsgroup: linux.dev.kernel
>
> Both x86 and ia64 now provide a dynamically shared object (DSO) for
> system call purposes (e.g., to speed up system calls and for signal
> trampoline/sigreturn purposes).  At the moment, the names of these
> DSOs are different:
> 
> 	x86:	linux-vsyscall.so.1
> 	ia64:	linux-gate.so.1
> 
> I think there is some value in using the same name on all platforms
> that support such a DSO.  vsyscall makes no sense for ia64, since
> there are no virtual syscalls (instead, ia64 linux provides a fast
> system call convention which, when coupled with light-weight system
> call handlers, provide full syscall semantics at more or less the
> speed of virtual system calls).
> 
> Not surprisingly, I like the name "linux-gate", since that is really
> what this DSO is all about: it's a gateway between user and kernel
> space.  However, if this name isn't appropriate for x86, perhaps we
> can find another name which will be acceptable to everybody.
> 

It's a pretty ugly name, quite frankly, since it doesn't explain what
it is a gate from or to.  linux-syscall.so.1 or linux-kernel.so.1
would make a lot more sense.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
