Return-Path: <linux-kernel-owner+w=401wt.eu-S1425642AbWLHQ5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425642AbWLHQ5g (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425641AbWLHQ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:57:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35849 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425617AbWLHQ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:57:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com>  <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> 
To: Christoph Lameter <clameter@sgi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 08 Dec 2006 16:56:57 +0000
Message-ID: <4595.1165597017@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> cmpxchg is the simplest solution to realize many other atomic operations and
> its widely available on a wide variety of platforms.

But by no means all.  Where it doesn't exist it can only be properly emulated
by something such as LL/SC if they are there.  If not, then you can't do a
safe cmpxchg on SMP.

> It is the most universal atomic instruction that I know of.

I think TAS-type things and XCHG-type things are more common.

In fact I think more things have LL/SC than have CMPXCHG.

David
