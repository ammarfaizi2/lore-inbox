Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSK1RGS>; Thu, 28 Nov 2002 12:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbSK1RGR>; Thu, 28 Nov 2002 12:06:17 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15885 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266100AbSK1RGQ>; Thu, 28 Nov 2002 12:06:16 -0500
Date: Thu, 28 Nov 2002 12:12:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19/20, 2.5 missing P4 ifdef ?
In-Reply-To: <20021128142437.GA23664@suse.de>
Message-ID: <Pine.LNX.3.96.1021128121018.12997B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2002, Dave Jones wrote:

> On Thu, Nov 28, 2002 at 03:17:53PM +0100, Margit Schubert-While wrote:
>  > Just noticed this in "include/asm-i386/processor.h" :
>  > 
>  > --- snip ---
>  > /* Prefetch instructions for Pentium III and AMD Athlon */
>  > #ifdef  CONFIG_MPENTIUMIII
>  > #define ARCH_HAS_PREFETCH
>  > extern inline void prefetch(const void *x)
>  > {
>  >         __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
>  > }
>  > #elif CONFIG_X86_USE_3DNOW
>  > --- end snip ---
>  > 
>  > The P4 has SSE and prefetch or no ?
> 
> It does. You seem to have found a bug.

A bug? An inefficiency, obviously, but it should be functionally correct,
no? Or is there a problem I've missed other than performance?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

