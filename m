Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSK1OKS>; Thu, 28 Nov 2002 09:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSK1OKS>; Thu, 28 Nov 2002 09:10:18 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:1240 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265523AbSK1OKS>; Thu, 28 Nov 2002 09:10:18 -0500
Message-Id: <4.3.2.7.2.20021128151157.00b522c0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 28 Nov 2002 15:17:53 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.19/20, 2.5 missing P4 ifdef ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed this in "include/asm-i386/processor.h" :

--- snip ---
/* Prefetch instructions for Pentium III and AMD Athlon */
#ifdef  CONFIG_MPENTIUMIII
#define ARCH_HAS_PREFETCH
extern inline void prefetch(const void *x)
{
         __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
}
#elif CONFIG_X86_USE_3DNOW
--- end snip ---

The P4 has SSE and prefetch or no ?

Margit 

