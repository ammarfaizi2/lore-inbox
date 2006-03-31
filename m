Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWCaRrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWCaRrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCaRrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:47:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15813 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751323AbWCaRrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:47:06 -0500
Date: Fri, 31 Mar 2006 09:46:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Hans Boehm <Hans.Boehm@hp.com>, Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <200603311837.34477.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0603310946120.6628@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
 <p73vetu921a.fsf@verdi.suse.de> <Pine.GHP.4.58.0603310808190.28478@tomil.hpl.hp.com>
 <200603311837.34477.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Andi Kleen wrote:

> On Friday 31 March 2006 18:22, Hans Boehm wrote:
> 
> > My impression is that approach (1) tends not to stick, since it involves
> > a substantial performance hit on architectures on which the fence is
> > not implicitly included in atomic operations.  Those include Itanium and
> > PowerPC.
> 
> At least the PPC people are eating the overhead because back when they
> didn't they had a long string of subtle powerpc only bugs caused by that

PPC has barriers for both smb_mb_before/after cases. IMHO we should do the 
same for ia64 and not fuzz around.

> It's a stability/maintainability vs performance issue. I doubt the 
> performance advantage would be worth the additional work. I guess
> with the engineering time you would need to spend getting all this right
> you could do much more fruitful optimizations.

Agreed.

