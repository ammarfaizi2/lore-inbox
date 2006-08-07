Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWHGDIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWHGDIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 23:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWHGDIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 23:08:31 -0400
Received: from ozlabs.org ([203.10.76.45]:50393 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750944AbWHGDIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 23:08:30 -0400
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
In-Reply-To: <200608070455.44237.ak@suse.de>
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
	 <1154919267.21647.7.camel@localhost.localdomain>
	 <200608070455.44237.ak@suse.de>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 13:08:26 +1000
Message-Id: <1154920106.21647.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 04:55 +0200, Andi Kleen wrote:
> On Monday 07 August 2006 04:54, Rusty Russell wrote:
> > On Sun, 2006-08-06 at 18:22 +0100, Hugh Dickins wrote:
> > > but I wonder how many other early_param
> > > "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> > > shows many such, i386 shows only one, I've not followed it up further.
> > 
> > Thanks Hugh.
> > 
> > Andrew, here's that i386 fix:
> 
> I had already fixed that one and the x86-64 ones.
> 
> But it still doesn't boot on x86-64 - gets into an endless loop
> at boot. I'm suspecting the code can't deal with duplicated
> prefixes.

Works fine here:

early_param("param", early_param1);
early_param("param2", early_param2);

I'm building an x86_64 kernel, and hoping it runs under qemu.  If so,
I'll find the problem...

Thanks,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

