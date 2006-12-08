Return-Path: <linux-kernel-owner+w=401wt.eu-S1425909AbWLHRGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425909AbWLHRGt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425908AbWLHRGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:06:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40851 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425909AbWLHRGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:06:45 -0500
Date: Fri, 8 Dec 2006 09:06:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it 
In-Reply-To: <4595.1165597017@redhat.com>
Message-ID: <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com> 
 <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk>  <4595.1165597017@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, David Howells wrote:

> > It is the most universal atomic instruction that I know of.
> 
> I think TAS-type things and XCHG-type things are more common.

Huh? The most popular architectures are i386 x86_64 sparc ia64 etc which 
all have one or the other form of cmpxchg (some issues with early sparc 
and i386).

And yes the xchg was the first multiprocessor instruction and therefore 
is also available on very old processors.

> In fact I think more things have LL/SC than have CMPXCHG.

LL/SC can be easily used to come up with a cmpxchg equivalent.
