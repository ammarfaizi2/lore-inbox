Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbSK2EoT>; Thu, 28 Nov 2002 23:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbSK2EoT>; Thu, 28 Nov 2002 23:44:19 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:23466
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S266959AbSK2EoS>; Thu, 28 Nov 2002 23:44:18 -0500
Subject: Re: 2.4.19/20, 2.5 missing P4 ifdef ?
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1021128121018.12997B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021128121018.12997B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1038545465.25442.7.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 28 Nov 2002 22:51:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-28 at 11:12, Bill Davidsen wrote:
> On Thu, 28 Nov 2002, Dave Jones wrote:
> 
> > On Thu, Nov 28, 2002 at 03:17:53PM +0100, Margit Schubert-While wrote:
> >  > Just noticed this in "include/asm-i386/processor.h" :
> >  > 
> >  > --- snip ---
> >  > /* Prefetch instructions for Pentium III and AMD Athlon */
> >  > #ifdef  CONFIG_MPENTIUMIII
> >  > #define ARCH_HAS_PREFETCH
> >  > extern inline void prefetch(const void *x)
> >  > {
> >  >         __asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
> >  > }
> >  > #elif CONFIG_X86_USE_3DNOW
> >  > --- end snip ---
> >  > 
> >  > The P4 has SSE and prefetch or no ?
> > 
> > It does. You seem to have found a bug.
> 
> A bug? An inefficiency, obviously, but it should be functionally correct,
> no? Or is there a problem I've missed other than performance?

IMHO, when building systems, any deficiency I find, is logged as a bug.
I'd imagine, anything perceived as a problem, should be treated this
way. Imho, performance, or lack of, is a bug, if a potential fix is
available. 

  --The GrandMaster
