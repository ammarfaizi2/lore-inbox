Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVEMQDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVEMQDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVEMQDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:03:54 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:19120 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262413AbVEMQDv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:03:51 -0400
In-Reply-To: <200505131749.20752.pluto@agmk.net>
References: <200505131749.20752.pluto@agmk.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <54f0f21514487ab2492daa91cc630a58@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [2.6.8] OOPS and SIGSEGV on altivec instruction on PowerPC 7540.
Date: Fri, 13 May 2005 11:03:35 -0500
To: "Pawel Sikora" <pluto@agmk.net>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is odd. the 2.6.8 kernel should have the code that causes a SIGILL 
if !CONFIG_ALTIVEC.  Can you enable CONFIG_KALLSYMS.

- kumar

On May 13, 2005, at 10:49 AM, Pawel Sikora wrote:

> Hi,
>
> simple runtime altivec detection from userspace causes an oops
>  on the `vand` instruction. kernel was built *without* CONFIG_ALTIVEC.
> i think kernel should return a SIGILL instead of an oops ;-)
>
> Oops: kernel access of bad area, sig: 11 [#65]
>  NIP: C0008B84 LR: C0007F2C SP: CF373F20 REGS: cf373e70 TRAP: 0300 Not 
> tainted
>  MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>  DAR: 00000088, DSISR: 40000000
>  TASK = c81e04f0[12983] 'altivec' THREAD: cf372000Last syscall: 174
>  GPR00: C0007F2C CF373F20 C81E04F0 00000004 00000004 00030001 00000000 
> 0FEE08D0
>  GPR08: 0000F932 C0007F2C 00009032 C0350000 081E0788 00000000 00000000 
> 100A37D8
>  GPR16: 100A0000 00000000 100A0000 00000000 10070000 100A37C8 100AEF08 
> 00000000
>  GPR24: 100A1108 00000000 100A59A8 3002AEF8 3002BB80 3002AE60 0FFEA6FC 
> 00000004
>  Call trace: [c0007f2c]
>
>
>
> processor       : 0
>  cpu             : 7450
>  clock           : 700MHz
>  revision        : 2.1 (pvr 8000 0201)
>  bogomips        : 696.32
>  machine         : PowerMac4,4
>  motherboard     : PowerMac4,4 MacRISC2 MacRISC Power Macintosh
>  detected as     : 80 (eMac)
>  pmac flags      : 00000001
>  L2 cache        : 256K unified
> memory          : 384MB
>  pmac-generation : NewWorld
>
> -- 
> The only thing necessary for the triumph of evil
>    is for good men to do nothing.
>                                             - Edmund Burke
> <altivec.c>
