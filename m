Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSHBNt2>; Fri, 2 Aug 2002 09:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHBNtD>; Fri, 2 Aug 2002 09:49:03 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:29170 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S313687AbSHBNsz>;
	Fri, 2 Aug 2002 09:48:55 -0400
Date: Fri, 2 Aug 2002 15:52:18 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: What does this error mean? "local symbols in discarded section .text.exit"
Message-ID: <20020802135218.GA15211@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020802.012040.105531210.davem@redhat.com> <008701c23a28$958ca300$6a01a8c0@wa1hco>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008701c23a28$958ca300$6a01a8c0@wa1hco>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 02 August 2002, at 09:29:09 -0400,
jeff millar wrote:

> I need some help debugging this kernel build problem.
> 
> drivers/built-in.o(.data+0x80f4): undefined reference to `local symbols in
> discarded section .te
> xt.exit'
> make: *** [vmlinux] Error 1
> 
A know problem with some combinations of binutils and kernel sources. As
Debian bintuils package says:

x You may experience problems linking older (and some newer) kernels with  x 
x this version of binutils.  This is not because of a bug in the linker,   x 
x but rather a bug in the kernel source.  This is being worked out and     x 
x fixed by the upstream kernel group in newer kernels, but not all of the  x 
x problems may have been fixed at this time.  Older kernel versions will   x 
x almost always exhibit the problem, however, and no attempts are being    x 
x made to fix those that we know of.                                       x 
x                                                                          x 
x There are a few work-arounds, but the most reliable is to edit the       x 
x linker script for your architecture (e.g. arch/i386/vmlinux.lds) and     x 
x remove the '*(.text.exit)' entry from the 'DISCARD' line.  It will       x 
x bloat the kernel somewhat, but it should link properly.                  x 

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
