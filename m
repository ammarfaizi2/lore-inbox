Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUFCXGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUFCXGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUFCXGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:06:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:18358 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264629AbUFCXGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:06:12 -0400
Date: Fri, 4 Jun 2004 01:06:10 +0200
From: Andi Kleen <ak@suse.de>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603230610.GE868@wotan.suse.de>
References: <20040602205025.GA21555@elte.hu> <200406031224.13319.suresh.b.siddha@intel.com> <20040603203709.GB868@wotan.suse.de> <200406031558.27495.suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031558.27495.suresh.b.siddha@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 03:58:27PM -0700, Siddha, Suresh B wrote:
> On Thursday 03 June 2004 13:37, Andi Kleen wrote:
> > > What do you mean by "in the future"? on x86, with the current no execute 
> > > patch, malloc() will be non-exec
> > 
> > On x86-64 the heap is executable right now at least.
> > 
> 
> oh! I see. Looks like only Ingo's exec-shield patch is doing that.

Maybe adding a new ELF header flag for that would be a good idea too.
Just not sure if gcc should set it by default or not.

But I fear chaging it for x86-64 generically could break programs
again.

-andi
