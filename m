Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVANEOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVANEOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVANEOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:14:34 -0500
Received: from colin2.muc.de ([193.149.48.15]:14852 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261889AbVANEOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:14:23 -0500
Date: 14 Jan 2005 05:14:21 +0100
Date: Fri, 14 Jan 2005 05:14:21 +0100
From: Andi Kleen <ak@muc.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, torvalds@osdl.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-ID: <20050114041421.GA41559@muc.de>
References: <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de> <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com> <41E4BCBE.2010001@yahoo.com.au> <20050112014235.7095dcf4.akpm@osdl.org> <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com> <20050112104326.69b99298.akpm@osdl.org> <Pine.LNX.4.58.0501121055490.11169@schroedinger.engr.sgi.com> <41E73EE4.50200@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E73EE4.50200@linux-m68k.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 04:39:16AM +0100, Roman Zippel wrote:
> Hi,
> 
> Christoph Lameter wrote:
> 
> >Introduction of the cmpxchg is one atomic operations that replaces the two
> >spinlock ops typically necessary in an unpatched kernel. Obtaining the
> >spinlock requires an spinlock (which is an atomic operation) and then the
> >release involves a barrier. So there is a net win for all SMP cases as far
> >as I can see.
> 
> But there might be a loss in the UP case. Spinlocks are optimized away, 
> but your cmpxchg emulation enables/disables interrupts with every access.

Only for 386s and STI/CLI is quite cheap there.

-Andi
