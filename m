Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTDPUX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264587AbTDPUX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:23:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264586AbTDPUXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:23:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: System Call parameters
Date: 16 Apr 2003 13:35:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7keqp$7p2$1@cesium.transmeta.com>
References: <Pine.LNX.4.53.0304161256130.11667@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.53.0304161256130.11667@chaos>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
>
> How does the kernel get more than five parameters?
> 
> Currently...
> 	eax	= function code
> 	ebx	= first parameter
> 	ecx	= second parameter
> 	edx	= third parameter
> 	esi	= fourth parameter
> 	edi	= fifth parameter
> 
> Some functions like mmap() take 6 parameters!
> Does anybody know how these parameters get passed?
> I have an "ultra-light" 'C' runtime library I have
> been working on and, so-far, I've got everything up
> to mmap()  (in syscall.h) (89 functions) working.
> I thought, maybe ebp was being used, but it doesn't
> seem to be the case.
> 

%ebp is used.

However, on i386, SYS_mmap is a four-parameter system call where the
last parameter is a pointer to a parameter block.  SYS_mmap2 is the
full six-parameter sane version.

You may want to check out klibc.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
