Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSK1OT3>; Thu, 28 Nov 2002 09:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSK1OT3>; Thu, 28 Nov 2002 09:19:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15848 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265541AbSK1OT2>;
	Thu, 28 Nov 2002 09:19:28 -0500
Date: Thu, 28 Nov 2002 14:24:37 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19/20, 2.5 missing P4 ifdef ?
Message-ID: <20021128142437.GA23664@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021128151157.00b522c0@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021128151157.00b522c0@pop.t-online.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 03:17:53PM +0100, Margit Schubert-While wrote:
 > Just noticed this in "include/asm-i386/processor.h" :
 > 
 > --- snip ---
 > /* Prefetch instructions for Pentium III and AMD Athlon */
 > #ifdef  CONFIG_MPENTIUMIII
 > #define ARCH_HAS_PREFETCH
 > extern inline void prefetch(const void *x)
 > {
 >         __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
 > }
 > #elif CONFIG_X86_USE_3DNOW
 > --- end snip ---
 > 
 > The P4 has SSE and prefetch or no ?

It does. You seem to have found a bug.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
