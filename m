Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUFCTYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUFCTYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUFCTYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 15:24:39 -0400
Received: from fmr05.intel.com ([134.134.136.6]:45509 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264238AbUFCTYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 15:24:36 -0400
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Thu, 3 Jun 2004 12:24:12 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040602205025.GA21555@elte.hu> <20040603072146.GA14441@elte.hu> <20040603124448.GA28775@elte.hu>
In-Reply-To: <20040603124448.GA28775@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031224.13319.suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 03 Jun 2004 19:24:09.0989 (UTC) FILETIME=[5865FB50:01C449A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 05:44, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > And do we have some way of on a per-process basis say "avoid NX
> > > because this old version of Oracle/flash/whatever-binary-thing doesn't
> > > run with it"?
> 
> [...]
> > 2) via a runtime method: via the i386 personality. So an application can
> >    trigger the 'legacy' Linux VM layout by e.g doing 'i386 java
> >    ./test.class'.
> > 
> > this is a hack in Fedora - we wanted to have a finegrained runtime
> > mechanism just in case. But it would be nice to have this upstream too -
> > e.g. via a PERSONALITY_3G?
> 
> i've attached a patch that provides a cleaner solution. It does 3
> changes:
> 
> - it adds a ADDR_SPACE_EXECUTABLE bit to the personality 'bug bits'
> section. This bit if set will make the stack executable. (if in the
> future we decide to make the malloc() heap non-exec [which i definitely
> think we should], that property will also listen to this bit.)

Ingo,

What do you mean by "in the future"? on x86, with the current no execute 
patch, malloc() will be non-exec

thanks,
suresh
